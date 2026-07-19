# DECISIONS.md

## Decided (do not silently reverse)
- 2026-07-19: State management = `flutter_bloc` (Bloc/Cubit), not GetX. Rationale: this fork already has 15+ global blocs wired in `main.dart` (`MultiBlocProvider`) plus feature-local blocs/cubits in every existing feature folder. Migrating to GetX for consistency with other projects (Onkur, FlexWork, Shell Agami) would require rewriting all working state logic app-wide for zero functional benefit and real regression risk. Confirmed by Dipu 2026-07-19.
- 2026-07-19: Prayer times calculated offline via `adhan_dart`, no API dependency.
- 2026-07-19: Repo initialized with git (previously untracked) and a baseline commit taken before any migration work, so Epic 0 dependency upgrades are reversible.

## Open questions (not yet decided — ask before assuming either way)
- Whether to support 6+ Quran translations at launch or just English+Bangla for v1.
- Whether Mosque Finder is in scope at all given no-backend constraint (maps data would need bundling or a lightweight offline POI dataset).
