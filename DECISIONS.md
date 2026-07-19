# DECISIONS.md

See `harness.yaml` for the machine-readable operating config (workflow gates, standard rules, epics/tasks, memory/checkpoint discipline) — `locked_decisions_ref` there points back at this file; don't duplicate locked decisions into `harness.yaml`, only reference them.

## Decided (do not silently reverse)
- 2026-07-19: State management = `flutter_bloc` (Bloc/Cubit), not GetX. Rationale: this fork already has 15+ global blocs wired in `main.dart` (`MultiBlocProvider`) plus feature-local blocs/cubits in every existing feature folder. Migrating to GetX for consistency with other projects (Onkur, FlexWork, Shell Agami) would require rewriting all working state logic app-wide for zero functional benefit and real regression risk. Confirmed by Dipu 2026-07-19.
- 2026-07-19: Prayer times calculated offline via `adhan_dart`, no API dependency.
- 2026-07-19: Repo initialized with git (previously untracked) and a baseline commit taken before any migration work, so Epic 0 dependency upgrades are reversible.

## Open questions (not yet decided — ask before assuming either way)
- Whether to support 6+ Quran translations at launch or just English+Bangla for v1.
- Whether Mosque Finder is in scope at all given no-backend constraint (maps data would need bundling or a lightweight offline POI dataset).
- 2026-07-19: `hive`/`hive_flutter` (locked in Section 5.2 tech stack) haven't published in ~4-5 years — pub.dev risk-check flags them stale. `hive_ce`/`hive_ce_flutter` is the actively-maintained, API-compatible community fork ("spiritual continuation of Hive v2"). Recommend swapping before TASK-016/018/027 (Hive-backed bookmarks/favorites/last-read) get built, but this changes a locked tech-stack entry, so needs Dipu's explicit call, not a silent substitution. `adhan_dart`, `hijri`, `get_it`, `injectable`, `go_router`, `mocktail` all checked clean (recent releases, no discontinued flags).
