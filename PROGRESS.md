# PROGRESS.md

## Current status
Active epic: EPIC 0 — Stabilize
Active task: TASK-003 — Confirm green build on a real/emulated device
Blocked on: nothing

## Completed
- [x] Repo git-initialized, baseline commit taken (pre-migration snapshot) — 2026-07-19
- [x] BRD/Gap-Analysis + agent operating manual written, then merged into a single `AMAR_DEEN_PLAN.md` (deleted the two source files), plus `DECISIONS.md`, `PROGRESS.md` — 2026-07-19
- [x] TASK-001: `pubspec.yaml` audit + upgrade — done 2026-07-19. Fixed stale SDK constraint (`>=2.18.2 <3.0.0` → `>=3.4.0 <4.0.0`, was mismatched against installed Flutter 3.44.3/Dart 3.12.2). Bumped 6 major-version-gap packages: `flutter_local_notifications` 20.1.0→22.1.0, `hydrated_bloc` 10.1.1→11.0.0, `connectivity_plus` 6.1.5→7.3.0, `share_plus` 12.0.1→13.2.1, `geocoding` 4.0.0→5.0.0, `just_audio` 0.9.40→0.10.6 / `audio_session` 0.1.25→0.2.4. `pub get` resolved cleanly (35 deps changed, no conflicts).
- [x] Fixed the one real breaking-API change from the bump: `geocoding` v5 removed the top-level `placemarkFromCoordinates` function in favor of a `Geocoding` class instance method. Updated `lib/src/core/util/bloc/location/location_bloc.dart:getAddressFromLatLng` to `geocoding_pkg.Geocoding().placemarkFromCoordinates(...)`, using an aliased import (`as geocoding_pkg`) since the app's own local model class `lib/src/core/util/model/geocoding.dart` is also named `Geocoding` and collided.
- [x] TASK-002: `keys.dart` gap resolved — 2026-07-19, per Dipu's call ("add template + make it optional"). Dart can't conditionally import a file that may not exist, so a copy-me template wouldn't actually stop the analyze error unless a dev remembered to copy it. Instead replaced the file itself: `lib/src/core/keys.dart` is now committed (removed from `.gitignore`) and contains `const kGoogleCloudApiKey = String.fromEnvironment('GOOGLE_CLOUD_API_KEY');` — no secret in the repo, real key supplied via `--dart-define=GOOGLE_CLOUD_API_KEY=...` at build time, empty-key case degrades gracefully (existing `Either`/try-catch error handling in `getAddress` already covers a failed API call, doesn't crash).
- [x] `flutter analyze`: **zero errors** — 40 issues remain, all pre-existing `info`-level `deprecated_member_use` (SVG `color:` → `colorFilter`, `ConcatenatingAudioSource`) and one `unreachable_switch_default` warning in `azkar_language.dart`. None are regressions from this work; none block a build.

## In progress
- [ ] TASK-003: green build check on a real/emulated device — not yet run this session (only `flutter analyze` verified so far, not a full `flutter build`/`flutter run`).

## Up next (do not start early)
- EPIC 1 (Architecture Scaffold) — do not start until TASK-003 closed

## Notes for next session
- `getAddress()` in `location_controller.dart` (the Google Maps HTTP reverse-geocode path, as opposed to `getAddressFromLatLng()` in `location_bloc.dart` which uses the on-device `geocoding` plugin and needs no API key) is currently **dead code** — nothing in `lib/` calls it. Worth flagging for Epic 2/6: it's also a live network call to Google, which conflicts with the offline-first constraint. Decide then whether to delete it or wire it in as an optional online enhancement.
- Existing codebase already uses `flutter_bloc ^9.1.1` / `hydrated_bloc ^11.0.0` (post-upgrade) — NOT the outdated 7.3.3 the BRD's upstream benchmark referenced.
- `.claude/` (local Claude Code session state) added to `.gitignore` — was untracked, not project source, don't commit it.
- `CLAUDE.md` at repo root documents current architecture (two-tier bloc structure, core module layout) — read it alongside this file; it predates the Clean Architecture migration and describes the pre-migration state accurately.
