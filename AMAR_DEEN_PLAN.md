# AMAR_DEEN_PLAN.md

**Project:** Amar Deen — offline-first Islamic companion app (Flutter)
**Base fork:** Sirat-E-Mustaqeem (372★, upstream: https://github.com/muhammadtalhasultan/Sirat-E-Mustaqeem)
**Benchmarked against:** Muslim Bangla, Muslims Day, Al Muslim, Muslim Pro
**Created:** 2026-07-19. Supersedes and merges `Sirat-E-Mustaqeem_Gap-Analysis_BRD_Refactor-Plan.md` + `AMAR_DEEN_AGENT_PROMPT.md` (deleted — this file is now the single source).

This is the standing operating manual **and** the BRD/architecture spec in one place. Read this file in full every session, then read `PROGRESS.md` (what's done) and `DECISIONS.md` (locked calls you must not silently reverse) before doing anything.

---

## 1. Objective & Constraints

Build a fully offline, no-backend Islamic companion app, Bangladesh-first (English + Bangla), matching feature parity with Muslim Bangla / Muslims Day.

Non-negotiable:
- **No backend.** Every feature works in airplane mode after first install.
- **Clean Architecture, Feature-First, Repository Pattern** (Section 5).
- **`flutter_bloc`/`Cubit` for state management — not GetX.** (locked, see `DECISIONS.md`)
- **Bangla + English localization from day one** — no hardcoded user-facing strings, ever, even in scaffolding.

---

## 2. Feature Gap Analysis

| # | Feature | This app | Muslim Bangla | Other leading apps | Gap |
|---|---|---|---|---|---|
| 1 | Quran Arabic text | ✅ | ✅ | ✅ | None |
| 2 | Quran translation | ✅ (single language) | ✅ (Bangla + Arabic) | ✅ (multi-language) | Missing Bangla + multi-language |
| 3 | Quran Tafsir | ❌ | ➖ (articles only) | ✅ | **Missing** |
| 4 | Word-by-word meaning | ❌ | ❌ | ✅ (Muslim Pro) | Missing (low prevalence) |
| 5 | Audio recitation, multi-Qari | ❌ | ✅ (Tilawat) | ✅ | **Missing** |
| 6 | Last-read / bookmarks | ❌ | ➖ | ✅ | **Missing** |
| 7 | Prayer times (offline calc) | ❌ (API-dependent) | ✅ | ✅ | **Missing — critical** |
| 8 | Azan audio + alarm toggle | ❌ | ✅ | ✅ | **Missing** |
| 9 | Prayer countdown / start-end times | ❌ | ✅ | ✅ | **Missing** |
| 10 | Voluntary prayers (Duha, Ishraq, Tahajjud) | ❌ | ➖ | ✅ (Muslims Day) | Missing |
| 11 | Forbidden prayer-time alerts | ❌ | ➖ | ✅ | Missing |
| 12 | Qibla compass | ✅ | ✅ | ✅ | None |
| 13 | Mosque finder | ❌ | ❌ | ✅ | Missing (lower priority) |
| 14 | Hadith collection | ✅ (40 Nawawi only) | ✅ (Bukhari, Muslim, more) | ✅ | Depth gap |
| 15 | Daily Dua & Azkar | ❌ | ✅ | ✅ | **Missing — critical** |
| 16 | Tasbih / digital Zikir counter | ❌ | ✅ | ✅ | **Missing** |
| 17 | Ramadan Suhoor/Iftar/Imsak + countdown | ❌ | ➖ | ✅ (Muslims Day) | Missing |
| 18 | Voluntary fasting reminders | ❌ | ❌ | ✅ (Muslims Day) | Missing (nice-to-have) |
| 19 | Hijri calendar | ❌ | ✅ | ✅ | **Missing** |
| 20 | Daily reminder notifications | ❌ | ➖ | ✅ | Missing |
| 21 | 99 Names of Allah | ❌ | ✅ | ✅ | Missing |
| 22 | Zakat calculator | ❌ | ✅ | ✅ (some) | Missing (medium) |
| 23 | Islamic articles / lectures | ❌ | ✅ | ➖ | Missing (low priority) |
| 24 | Ask Scholar Q&A / Voice call | ❌ | ✅ | ❌ (rare) | **Out of scope** — needs backend |
| 25 | Matrimonial service | ❌ | ✅ | ❌ | **Out of scope** — unrelated |
| 26 | Live Makkah/Madinah streaming | ❌ | ✅ | ➖ | **Out of scope** — needs streaming infra |
| 27 | Hajj & Umrah guide | ❌ | ✅ | ➖ | Missing (content-only, low effort) |
| 28 | Bangla localization | ❌ | ✅ | ✅ | **Missing — critical for BD market** |
| 29 | Light/dark theme | ⚠️ present (`ThemeBloc`), unverified in UI | ✅ | ✅ | Verify only |
| 30 | Home-screen widgets | ❌ | ❌ | ✅ (Al Muslim) | Missing (nice-to-have) |
| 31 | Offline-first architecture | ❌ (prayer times via API) | ➖ | ✅ | **Missing — core requirement** |

Legend: ✅ has it · ➖ partial/unclear · ❌ absent

**Critical gaps:** offline prayer-time calc, Dua/Azkar module, Tasbih counter, Hijri calendar, Bangla localization, Azan alarm system.
**Moderate gaps:** Tafsir, audio recitation, word-by-word Quran, Ramadan tools, 99 Names, Zakat calculator, daily reminders.
**Out of scope this phase:** Ask Scholar Q&A, voice-call-to-Mufti, matrimonial, live streaming, mosque finder — all need backend/server infra or live data feeds that conflict with the no-backend constraint.

---

## 3. Priority Matrix

| Feature | Priority | Complexity | Approach |
|---|---|---|---|
| Offline prayer time calculation | High | Medium | Replace API with `adhan_dart` |
| Azan audio + alarm toggle | High | Medium | `flutter_local_notifications` + audio asset |
| Dua & Azkar module | High | Medium | New module; Hisnul Muslim–style content |
| Tasbih counter | High | Low | In-house, trivial state + haptics |
| Hijri calendar | High | Low | `hijri` package (pure Dart, offline) |
| Bangla localization | High | Medium | `intl` + `.arb` files |
| Prayer countdown / start-end times | High | Low | UI on top of `adhan_dart` output |
| Dependency/SDK upgrade | High (prerequisite) | Medium-High | See TASK-001 (done) |
| Voluntary prayers (Duha/Ishraq/Tahajjud) | Medium | Low | Extend `adhan_dart` calc |
| Ramadan Suhoor/Iftar/Imsak + countdown | Medium | Low | Derive from Fajr/Maghrib |
| Quran audio recitation | Medium | Medium-High | EveryAyah/Quran.com CDN + Qari selector |
| Quran Tafsir | Medium | Medium | Tafsir JSON dataset + reader UI |
| Last-read / bookmarks | Medium | Low | Hive |
| 99 Names of Allah | Low | Low | Static content |
| Zakat calculator | Low | Low | Formula-driven |
| Daily reminder notifications | Low | Low-Medium | Reuse Azan notification infra |
| Home-screen widgets | Low | Medium-High | `home_widget` (Android) / WidgetKit (iOS) |
| Mosque finder | Low | High | Deprioritized — no-backend conflict |
| Hajj & Umrah guide | Low | Low | Static content |
| Voluntary fasting reminders | Low | Low | Extend Hijri calendar logic |

---

## 4. Requirements Summary

**Functional:** on-device prayer time calc (no remote API) · Azan sound + per-prayer notification toggle · live countdown + current prayer window · full Quran text (Arabic) + English/Bangla translation + per-Ayah Tafsir · bookmark/resume last-read Ayah · categorized Dua/Azkar library with favorites · digital Tasbih counter with resettable target · Hijri date display + Gregorian conversion · Ramadan Suhoor/Iftar/Imsak countdown · English/Bangla language switch · light/dark theme switch · Qibla compass via device sensors.

**Non-functional:** offline-first (all core features work with zero network after install) · cold start <2s on mid-range Android · prayer calc <100ms · Azan notifications reliable across background/reboot (`flutter_local_notifications` exact alarms + Android boot-completed handling) · Clean Architecture separation · domain/data layers unit-testable without widget bindings · all strings in `.arb` from day one · location/sensor usage on-demand, not continuous polling.

**Success criteria:** all High-priority features implemented and airplane-mode verified · zero network calls for prayer times/Quran/Duas/Hijri calendar · clean `flutter analyze`, no deprecated-API warnings introduced · presentation never imports from `data/` directly · Bangla covers 100% of user-facing strings.

---

## 5. Architecture

### 5.1 Folder structure (Clean Architecture + Feature-First)

```
lib/
├── core/
│   ├── constants/
│   ├── error/                    # Failure & Exception classes
│   ├── theme/
│   ├── localization/
│   ├── di/                       # get_it + injectable setup
│   ├── routing/                  # go_router
│   ├── notifications/            # shared local-notification scheduling
│   ├── utils/
│   └── widgets/
├── features/
│   ├── prayer_times/{data,domain,presentation}/
│   ├── quran/{data,domain,presentation}/
│   ├── dua_azkar/{data,domain,presentation}/
│   ├── tasbih/{data,domain,presentation}/
│   ├── hijri_calendar/{data,domain,presentation}/
│   ├── ramadan/{data,domain,presentation}/
│   ├── qibla/{data,domain,presentation}/
│   ├── hadith/{data,domain,presentation}/
│   └── settings/{data,domain,presentation}/
├── app.dart
└── main.dart
```

- **`domain/`** — pure Dart, zero Flutter/data imports. Entities, abstract repository interfaces, single-responsibility use cases (`GetTodayPrayerTimes`, `GetSurahById`, `ToggleDuaFavorite`).
- **`data/`** — implements domain repository interfaces. Local data sources (`adhan_dart`, bundled Quran JSON/SQLite, Hive boxes) + models mapping to domain entities.
- **`presentation/`** — widgets/screens + **Bloc/Cubit** (not GetX) calling use cases, never data sources directly. Follows the existing part-file convention already in this codebase: `x_bloc.dart` + `part 'x_event.dart'` + `part 'x_state.dart'` (see `lib/src/core/util/bloc/database/database_bloc.dart` for the pattern).

Repository pattern, apply to every feature:

```dart
// domain/repositories/<feature>_repository.dart
abstract class FeatureRepository {
  Future<Either<Failure, Entity>> getSomething();
}

// data/repositories/<feature>_repository_impl.dart
class FeatureRepositoryImpl implements FeatureRepository {
  final LocalDataSource localDataSource;
  FeatureRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, Entity>> getSomething() async {
    try {
      final result = await localDataSource.fetch();
      return Right(result.toEntity());
    } catch (e) {
      return Left(LocalFailure(e.toString()));
    }
  }
}
```

### 5.2 Tech stack (locked — see `DECISIONS.md`)

| Concern | Choice |
|---|---|
| State management | `flutter_bloc` (Bloc/Cubit) — already fully in place, not GetX |
| DI | get_it + injectable |
| Prayer time calculation | `adhan_dart` (offline) |
| Hijri calendar | `hijri` package |
| Local storage (bookmarks, favorites, settings) | Hive |
| Local notifications | `flutter_local_notifications` |
| Localization | Flutter `intl` + `.arb` |
| Navigation | `go_router` |
| Testing | `flutter_test` + `mocktail` |

Do not introduce alternatives without flagging it as a decision request, not a silent substitution.

### 5.3 Migration strategy — incremental phases

1. **Phase 0 — Stabilize** (Epic 0): upgrade Flutter SDK/deps, fix build breaks, clean `flutter analyze`.
2. **Phase 1 — Scaffold** (Epic 1): `core/` + `features/` skeleton alongside existing code, no deletion yet.
3. **Phase 2 — Migrate feature by feature**, simplest first to validate the pattern before Quran (largest): Qibla → Tasbih (new) → Hijri Calendar (new) → Prayer Times (replace API) → Dua/Azkar (new) → Hadith → Quran.
4. **Phase 3 — Remove legacy code** once each feature's new implementation is verified in a real build.
5. **Phase 4 — New feature buildout** (Ramadan tools, Bangla localization, notifications) on the clean structure.

### 5.4 Risks

| Risk | Mitigation |
|---|---|
| Dependency upgrade breaks existing UI | Manual QA pass before merging Phase 0 |
| Quran module migration regressions | Migrate last, after pattern proven on smaller features |
| Azan reliability on Android (Doze, OEM battery killers) | Exact alarms + guide users to disable battery optimization |
| Scope creep vs. bandwidth | Strict High → Medium → Low order; don't start Medium before High in an earlier epic is done |

### 5.5 Best practices
- One feature = one folder with its own `data/domain/presentation` — no cross-feature imports except through `core/`.
- Domain layer has zero Flutter/package imports — fast unit tests, no widget bindings.
- All repository access through interfaces — mockable via `mocktail`.
- Use cases are single-responsibility, not fat repositories called directly from UI.
- PR checklist: presentation layer never imports from `data/`.

---

## 6. Operating Rules (every session, no exceptions)

### 6.1 Analysis-first, confirmation-gated workflow
For every task:
1. **Analyze** — read the relevant existing code before touching anything. State what you found.
2. **Propose** — short plan: files touched, pattern followed, uncertainties.
3. **Confirm** — stop and ask before writing code, unless trivial (single file, <20 lines, no architectural decision). When in doubt, ask.
4. **Implement.**
5. **Report** — update `PROGRESS.md` before ending the session or moving to the next task.

### 6.2 Architectural discipline
- `presentation/` never imports from `data/` directly — always through `domain/` interfaces.
- Never introduce a second state management approach alongside `flutter_bloc` without flagging it and asking.
- Every feature module self-contained under `features/<name>/` — no reaching into another feature's internals; cross-feature needs go through `core/`.
- No feature ships without unit tests for its use cases and an airplane-mode verification note in `PROGRESS.md`.

### 6.3 Scope discipline
- Strict High → Medium → Low from Section 3. Don't start Medium/Low while an earlier-epic High task is incomplete, unless told to reprioritize.
- New scope discovered mid-task → propose it as a new task in `PROGRESS.md`, don't silently expand current task.

### 6.4 Reversibility rule
- Only what's under "Decided" in `DECISIONS.md` is locked. A past session finishing a task, or a past positive reaction, is not a lock — check before assuming.
- Don't reverse a locked decision without explicit new instruction in the current session.

### 6.5 Code quality bar
- Null-safety strict, no `dynamic` unless unavoidable (third-party JSON).
- Doc comment on every public class/method in `domain/`.
- effective_dart lint clean; zero analyzer warnings before marking a task done.
- Bangla + English strings added to `.arb` in the same commit that introduces the string.

### 6.6 Version control
- Repo is git-tracked from 2026-07-19 (baseline commit precedes migration work). Commit at the end of every completed task, small and reviewable.
- Never `push --force`, `reset --hard`, or discard uncommitted work without `git status` + confirming with Dipu first.

---

## 7. Epics & Tasks

### EPIC 0 — Stabilize
- [x] **TASK-001**: Audit `pubspec.yaml`, fix SDK constraint, upgrade dependencies. **Done 2026-07-19** — see `PROGRESS.md` for full detail (SDK constraint fixed, 6 major-version packages bumped, one breaking API fixed in `location_bloc.dart`, `pub get` clean).
- [x] **TASK-002**: Resolve remaining build-breaking issues. **Done 2026-07-19** — `keys.dart` now committed, reads key via `String.fromEnvironment`, no secret in repo, degrades gracefully. `flutter analyze` has zero errors.
- [x] **TASK-003**: Confirm green build on a real/emulated device. **Done 2026-07-19** — required a full Android Gradle toolchain migration (Gradle 7.4→8.14.2, AGP 7.1.2→8.11.1, Kotlin 1.6.10→2.2.20) plus replacing 2 dead plugins whose native code used removed Flutter v1-embedding APIs (`flutter_native_timezone`→`flutter_timezone`, `motion_sensors`→`flutter_qiblah`). Full blow-by-blow in `PROGRESS.md`. **Epic 0 is now fully closed.**

### EPIC 1 — Architecture Scaffold
- [ ] **TASK-004**: Create `core/` + `features/` folder skeleton (Section 5.1), placeholder files only.
- [ ] **TASK-005**: `get_it` + `injectable` DI container in `core/di/`.
- [ ] **TASK-006**: `go_router` setup in `core/routing/`.
- [ ] **TASK-007** (partial): Migrate `Qibla` feature end-to-end — proof of pattern, smallest feature first. Sensor/bearing engine already replaced (`motion_sensors`→`flutter_qiblah`) as a side effect of TASK-003's build fix, collapsing `QiblaBloc`+`AngleBloc` into one bloc. Folder move into `data/domain/presentation` still open.
- [ ] **TASK-008**: Migrate `Theme` (light/dark) into `core/theme/`, verify toggle still works.

### EPIC 2 — Offline Prayer Core
- [ ] **TASK-009**: `PrayerRepository` interface + `adhan_dart`-backed impl in `features/prayer_times/`.
- [ ] **TASK-010**: Remove existing prayer-time API dependency entirely.
- [ ] **TASK-011**: Prayer countdown + start/end time UI.
- [ ] **TASK-012**: Voluntary prayer times (Duha, Ishraq, Tahajjud).
- [ ] **TASK-013**: Azan alarm system — `flutter_local_notifications` scheduling, per-prayer toggle, exact-alarm/Doze handling.
- [ ] **TASK-014**: Airplane-mode manual verification, logged in `PROGRESS.md`.

### EPIC 3 — Worship Essentials
- [ ] **TASK-015**: `dua_azkar` feature — categorized library, bundled local JSON/asset data.
- [ ] **TASK-016**: Favorite/bookmark for Dua/Azkar via Hive.
- [ ] **TASK-017**: `tasbih` feature — counter, resettable target, haptics.
- [ ] **TASK-018**: `hijri_calendar` feature via `hijri` package, current Hijri date across relevant screens.

### EPIC 4 — Localization
- [ ] **TASK-019**: Externalize all existing strings to `.arb` (English baseline).
- [ ] **TASK-020**: Bangla `.arb` translations.
- [ ] **TASK-021**: Language switcher in Settings, persisted in Hive.

### EPIC 5 — Ramadan Tools
- [ ] **TASK-022**: Suhoor/Iftar/Imsak derived from Fajr/Maghrib, countdown UI.
- [ ] **TASK-023**: Voluntary fasting reminders (Mon/Thu, Ayyam al-Beed, Arafah) via Hijri calendar.

### EPIC 6 — Quran Enhancement
- [ ] **TASK-024**: Migrate Quran feature into Clean Architecture structure.
- [ ] **TASK-025**: Tafsir data + reader UI per Ayah.
- [ ] **TASK-026**: Audio recitation + Qari selector (bundle vs. stream from EveryAyah/Quran.com — confirm with Dipu, streaming is a soft network dependency, must be optional/cached).
- [ ] **TASK-027**: Last-read position + bookmarks via Hive.

### EPIC 7 — Extras (low priority, don't start before Epics 0–6 substantially done)
- [ ] **TASK-028**: 99 Names of Allah — static content.
- [ ] **TASK-029**: Zakat calculator — formula-driven.
- [ ] **TASK-030**: Daily reminder notifications, reusing TASK-013's notification service.

### EPIC 8 — Polish (low priority, discuss scope before starting)
- [ ] **TASK-031**: Home-screen widgets (Android `home_widget`; iOS WidgetKit if scoped in).
- [ ] **TASK-032**: Confirm with Dipu whether Mosque Finder stays in scope (see `DECISIONS.md` open question).
- [ ] **TASK-033**: Hajj & Umrah guide — static content.

---

## 8. Session Start Checklist

- [ ] Read this file in full
- [ ] Read `PROGRESS.md`
- [ ] Read `DECISIONS.md`
- [ ] State current Epic/Task being resumed
- [ ] New task → Analyze → Propose → Confirm (Section 6.1) before writing code
- [ ] End of session → update `PROGRESS.md`, commit, update `DECISIONS.md` if a new lock was made

---

*This file supersedes any conflicting instruction from a prior session summary. If something here looks outdated given the current code, flag it and ask rather than silently deviating.*
