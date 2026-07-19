# PROGRESS.md

## Current status
Active epic: EPIC 0 — Stabilize
Active task: TASK-002 — Fix remaining build-breaking issues (only known one left is the pre-existing `keys.dart` gap, see notes)
Blocked on: nothing

## Completed
- [x] Repo git-initialized, baseline commit taken (pre-migration snapshot) — 2026-07-19
- [x] BRD/Gap-Analysis + agent operating manual written, then merged into a single `AMAR_DEEN_PLAN.md` (deleted the two source files), plus `DECISIONS.md`, `PROGRESS.md` — 2026-07-19
- [x] TASK-001: `pubspec.yaml` audit + upgrade — done 2026-07-19. Fixed stale SDK constraint (`>=2.18.2 <3.0.0` → `>=3.4.0 <4.0.0`, was mismatched against installed Flutter 3.44.3/Dart 3.12.2). Bumped 6 major-version-gap packages: `flutter_local_notifications` 20.1.0→22.1.0, `hydrated_bloc` 10.1.1→11.0.0, `connectivity_plus` 6.1.5→7.3.0, `share_plus` 12.0.1→13.2.1, `geocoding` 4.0.0→5.0.0, `just_audio` 0.9.40→0.10.6 / `audio_session` 0.1.25→0.2.4. `pub get` resolved cleanly (35 deps changed, no conflicts).
- [x] Fixed the one real breaking-API change from the bump: `geocoding` v5 removed the top-level `placemarkFromCoordinates` function in favor of a `Geocoding` class instance method. Updated `lib/src/core/util/bloc/location/location_bloc.dart:getAddressFromLatLng` to `geocoding_pkg.Geocoding().placemarkFromCoordinates(...)`, using an aliased import (`as geocoding_pkg`) since the app's own local model class `lib/src/core/util/model/geocoding.dart` is also named `Geocoding` and collided.
- [x] `flutter analyze` clean except the pre-existing `keys.dart` gap (see notes) — 42 issues remain, all either that gap or unrelated pre-existing `deprecated_member_use` info-level notices (SVG `color:` param → `colorFilter`, `ConcatenatingAudioSource` deprecation) and one pre-existing `unreachable_switch_default` warning in `azkar_language.dart`. None of these are regressions from the dependency upgrade.

## In progress
- [ ] TASK-002: Fix build-breaking issues — effectively done; only open item is `keys.dart`, which needs a decision (see notes), not a code fix.

## Up next (do not start early)
- TASK-003: Confirm green build on a real/emulated device (needs `keys.dart` resolved first, or a build config that tolerates its absence)
- EPIC 1 (Architecture Scaffold) — do not start until TASK-002/003 closed

## Notes for next session
- **`keys.dart` gap (pre-existing, not caused by this upgrade):** `lib/src/core/keys.dart` is `.gitignore`d and does not exist in the repo — it's expected to hold `const kGoogleCloudApiKey = '...'`, referenced only by `lib/src/core/util/controller/location_controller.dart`. No template/example file exists. This means `flutter analyze` (and presumably any build that reaches that code path) fails from a fresh clone regardless of dependency versions. Options for next session: (a) get the real key from Dipu and create the file locally (never commit it), (b) add a `keys.example.dart` template + make the import conditional/optional, or (c) fold Google geocoding reverse-lookup into the offline-first rework later (Epic 2/6 territory) so it's not a blocking dependency at all. Need Dipu's call on which.
- Existing codebase already uses `flutter_bloc ^9.1.1` / `hydrated_bloc ^11.0.0` (post-upgrade) — NOT the outdated 7.3.3 the BRD's upstream benchmark referenced.
- `.claude/` (local Claude Code session state) added to `.gitignore` — was untracked, not project source, don't commit it.
- `CLAUDE.md` at repo root documents current architecture (two-tier bloc structure, core module layout) — read it alongside this file; it predates the Clean Architecture migration and describes the pre-migration state accurately.
