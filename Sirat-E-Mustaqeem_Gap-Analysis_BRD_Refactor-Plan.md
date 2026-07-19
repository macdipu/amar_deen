# Sirat-E-Mustaqeem: Feature Gap Analysis, BRD & Clean Architecture Migration Plan

**Prepared for:** Polygon Technology — Islamic companion app initiative
**Baseline codebase:** [Sirat-E-Mustaqeem](https://github.com/muhammadtalhasultan/Sirat-E-Mustaqeem) (372★, Flutter, flutter_bloc)
**Benchmarked against:** Muslim Bangla, Muslims Day, Al Muslim, Muslim Pro, and other leading open-source/commercial Islamic apps
**Date:** July 19, 2026
**Amended:** July 19, 2026 — state-management decision locked to `flutter_bloc` (see note in Section 4.6 / 5.5). See `DECISIONS.md`.

---

## 1. Feature Comparison Table

| # | Feature | Sirat-E-Mustaqeem | Muslim Bangla | Other leading apps (Muslims Day / Al Muslim / Muslim Pro) | Gap |
|---|---|---|---|---|---|
| 1 | Quran Arabic text | ✅ | ✅ | ✅ | None |
| 2 | Quran translation | ✅ (single language) | ✅ (Bangla + Arabic) | ✅ (multi-language) | Missing Bangla + multi-language |
| 3 | Quran Tafsir | ❌ | ➖ (articles, not integrated tafsir) | ✅ | **Missing** |
| 4 | Word-by-word meaning | ❌ | ❌ | ✅ (Muslim Pro) | Missing (low prevalence though) |
| 5 | Audio recitation, multi-Qari | ❌ | ✅ (Tilawat) | ✅ | **Missing** |
| 6 | Last-read / bookmarks | ❌ | ➖ | ✅ | **Missing** |
| 7 | Prayer times (offline calc) | ❌ (API-dependent) | ✅ | ✅ | **Missing — critical** |
| 8 | Azan audio + alarm toggle | ❌ (not confirmed in code) | ✅ | ✅ | **Missing** |
| 9 | Prayer countdown / start-end times | ❌ | ✅ | ✅ | **Missing** |
| 10 | Voluntary prayers (Duha, Ishraq, Tahajjud) | ❌ | ➖ | ✅ (Muslims Day) | Missing |
| 11 | Forbidden prayer-time alerts | ❌ | ➖ | ✅ | Missing |
| 12 | Qibla compass | ✅ | ✅ | ✅ | None |
| 13 | Mosque finder | ❌ | ❌ | ✅ (Al Muslim, Muslim Pro) | Missing (lower priority) |
| 14 | Hadith collection | ✅ (40 Nawawi only) | ✅ (Bukhari, Muslim, more) | ✅ | Depth gap |
| 15 | Daily Dua & Azkar | ❌ | ✅ | ✅ | **Missing — critical** |
| 16 | Tasbih / digital Zikir counter | ❌ | ✅ | ✅ | **Missing** |
| 17 | Ramadan Suhoor/Iftar/Imsak + countdown | ❌ | ➖ | ✅ (Muslims Day) | Missing |
| 18 | Voluntary fasting reminders (Mon/Thu, Ayyam al-Beed, Arafah) | ❌ | ❌ | ✅ (Muslims Day) | Missing (nice-to-have) |
| 19 | Hijri calendar | ❌ | ✅ | ✅ | **Missing** |
| 20 | Daily reminder notifications (verse/Hadith/Darood) | ❌ | ➖ | ✅ | Missing |
| 21 | 99 Names of Allah | ❌ | ✅ | ✅ | Missing |
| 22 | Zakat calculator | ❌ | ✅ | ✅ (some) | Missing (medium priority) |
| 23 | Islamic articles / lectures / books | ❌ | ✅ | ➖ | Missing (content-heavy, lower priority) |
| 24 | Ask Scholar Q&A / Voice call to Mufti | ❌ | ✅ | ❌ (rare) | Out of scope — requires backend, skip |
| 25 | Matrimonial service | ❌ | ✅ | ❌ | Out of scope — unrelated to app purpose |
| 26 | Live Makkah/Madinah streaming | ❌ | ✅ | ➖ | Out of scope — needs streaming infra/backend |
| 27 | Hajj & Umrah guide | ❌ | ✅ | ➖ | Missing (content-only, low effort) |
| 28 | Bangla localization | ❌ (not confirmed) | ✅ | ✅ (Muslims Day, Al Muslim) | **Missing — critical for BD market** |
| 29 | Light/dark theme | ⚠️ Present in code (`ThemeBloc`) but unverified in UI | ✅ | ✅ | Verify only |
| 30 | Home-screen widgets (prayer times) | ❌ | ❌ | ✅ (Al Muslim) | Missing (nice-to-have) |
| 31 | Offline-first architecture | ❌ (prayer times via API) | ➖ | ✅ (Muslim Prayer Times app explicitly offline) | **Missing — core requirement** |

Legend: ✅ has it · ➖ partial/unclear · ❌ absent

---

## 2. Gap Analysis Summary

**Critical gaps (block feature parity):**
- No offline prayer-time calculation — currently hits an external API, which conflicts with your "no backend" requirement and is a single point of failure.
- No Dua/Azkar module — entirely absent, yet present in every competitor.
- No Tasbih counter — trivial to build, present everywhere else.
- No Hijri calendar — needed for Ramadan/fasting features and Islamic date displays.
- No Bangla localization — your primary target market (Bangladesh, per Muslim Bangla's dominance) is unaddressed.
- No Azan alarm/notification system — core expectation of any prayer app.

**Moderate gaps (expected but not core):**
- Tafsir, audio recitation, word-by-word Quran features.
- Ramadan Suhoor/Iftar countdowns, voluntary fasting reminders.
- 99 Names of Allah, Zakat calculator, daily reminder notifications.

**Out of scope (require backend/infra you've explicitly excluded):**
- Ask Scholar Q&A, Voice call to Mufti, Matrimonial service, Live streaming — these need server-side infrastructure and are not aligned with a no-backend, offline Flutter app. Recommend excluding from roadmap.

**Technical debt (not a feature gap, but blocks everything):**
- `flutter_bloc` v7.3.3 and other dependencies are outdated; existing GitHub issues report build failures on fresh installs. This must be resolved before feature work begins.

> **Note:** the actual `amar_deen` codebase (this repo) is already on `flutter_bloc ^9.1.1` / `hydrated_bloc ^10.1.1`, not the outdated 7.3.3 referenced above — that figure describes the upstream Sirat-E-Mustaqeem baseline this BRD was benchmarked against, not this fork's current `pubspec.yaml`. TASK-001 re-audits the actual current versions.

---

## 3. Feature Recommendations & Priority Matrix

| Feature | Priority | User value | Implementation complexity | Source/approach |
|---|---|---|---|---|
| Offline prayer time calculation | High | Very high | Medium | Replace API with `adhan_dart` |
| Azan audio + alarm toggle | High | Very high | Medium | `flutter_local_notifications` + audio asset |
| Dua & Azkar module | High | Very high | Medium | New module; content from Hisnul Muslim datasets |
| Tasbih counter | High | High | Low | Build in-house, trivial state + haptics |
| Hijri calendar | High | High | Low | `hijri` package (pure Dart, offline) |
| Bangla localization | High | Very high (BD market) | Medium | Flutter `intl` + `.arb` files |
| Prayer countdown / start-end times | High | High | Low | UI work on top of `adhan_dart` output |
| Voluntary prayers (Duha/Ishraq/Tahajjud) | Medium | Medium | Low | Extend `adhan_dart` calculation |
| Ramadan Suhoor/Iftar/Imsak + countdown | Medium | High (seasonal) | Low | Derive from Fajr/Maghrib times |
| Dependency/SDK upgrade | High (prerequisite) | High (stability) | Medium-High | Upgrade Flutter SDK, `flutter_bloc`, migrate deprecated APIs |
| Quran audio recitation | Medium | High | Medium-High | Audio CDN (EveryAyah) + Qari selector |
| Quran Tafsir | Medium | Medium | Medium | Tafsir JSON dataset + reader UI |
| Last-read / bookmarks | Medium | Medium | Low | Local storage (Hive/sqflite) |
| 99 Names of Allah | Low | Medium | Low | Static content module |
| Zakat calculator | Low | Medium | Low | Formula-driven, no external data |
| Daily reminder notifications | Low | Medium | Low-Medium | Scheduled local notifications, reuse azan infra |
| Home-screen widgets | Low | Medium | Medium-High (native platform channels) | Android `home_widget` package, iOS WidgetKit |
| Mosque finder | Low | Low-Medium | High (needs maps/geo data) | Google Maps or OSM, deprioritize given no-backend goal |
| Hajj & Umrah guide | Low | Low | Low | Static content pages |
| Voluntary fasting reminders | Low | Low-Medium | Low | Extend Hijri calendar logic |

---

## 4. Business Requirements Document (BRD)

### 4.1 Project Objectives
- Deliver a fully offline, no-backend Islamic companion app for Muslims (with a Bangladesh-first market focus) that matches feature parity with Muslim Bangla and other leading apps.
- Establish a maintainable, scalable Flutter codebase using Clean Architecture, replacing the current unmaintained/outdated foundation.
- Ensure the app works reliably without network dependency for its core functions (prayer times, Quran, Duas, Hijri calendar).

### 4.2 Scope

**In scope:**
- Prayer times, Azan, Qibla, Quran (text/translation/tafsir/audio), Duas & Azkar, Tasbih, Hijri calendar, Ramadan tools, Bangla + English localization, dark/light theme.

**Out of scope (this phase):**
- Ask Scholar Q&A, Voice call to Mufti, Matrimonial service, Live Makkah/Madinah streaming, Mosque finder (all require backend/server infrastructure or third-party live data feeds not aligned with the no-backend constraint).

### 4.3 Functional Requirements
1. The app shall calculate prayer times entirely on-device using device location/coordinates, without calling a remote API.
2. The app shall play an Azan sound and trigger a local notification at each prayer time, with a per-prayer on/off toggle.
3. The app shall display a live countdown to the next prayer and the start/end window of the current prayer.
4. The app shall provide the full Quran text (Arabic), at least one translation (English + Bangla), and shall support adding Tafsir per Ayah.
5. The app shall allow bookmarking and resuming the last-read Ayah.
6. The app shall provide a categorized library of daily Duas and Azkar (morning, evening, post-Salah, etc.) with a bookmark/favorite mechanism.
7. The app shall provide a digital Tasbih counter with a resettable target count.
8. The app shall display the current Hijri date and convert between Hijri/Gregorian dates.
9. The app shall calculate and display Ramadan Suhoor, Iftar, and Imsak times with countdowns.
10. The app shall support English and Bangla language switching from settings.
11. The app shall support light and dark themes, switchable from settings.
12. The app shall provide a Qibla compass using device sensors.

### 4.4 Non-Functional Requirements
- **Offline-first:** All core features (prayer times, Quran, Duas, Hijri calendar, Qibla) must function with no network connection after first install/data bundling.
- **Performance:** Cold start under 2 seconds on a mid-range Android device; prayer-time calculation under 100ms.
- **Reliability:** Azan notifications must fire reliably even when the app is backgrounded or the device is restarted (requires correct use of `flutter_local_notifications` scheduling + boot-completed handling on Android).
- **Maintainability:** Codebase must follow Clean Architecture with clear separation of concerns to support long-term feature additions.
- **Testability:** Domain and data layers must be unit-testable independent of Flutter widgets.
- **Localization-ready:** All user-facing strings externalized to `.arb` files from day one.
- **Battery/resource efficiency:** Location and sensor usage (Qibla, prayer times) must be minimized to on-demand rather than continuous polling.

### 4.5 Recommended Feature Roadmap
See Section 8 (Implementation Roadmap) for phased detail.

### 4.6 Technical Considerations
- Current dependency versions (`flutter_bloc` 7.3.3, older Flutter SDK) referenced in the upstream baseline are outdated — this fork is already on `flutter_bloc ^9.1.1`, but TASK-001 must still audit and upgrade all other `pubspec.yaml` dependencies and the Dart SDK constraint (`>=2.18.2 <3.0.0` is well behind the installed Flutter 3.44.3 / Dart 3.12 toolchain) before feature work begins.
- Prayer-time API dependency must be replaced with `adhan_dart` to satisfy the no-backend constraint.
- Recommend Clean Architecture + Feature-First structure + Repository Pattern (detailed in Section 5) to make the above additions maintainable.
- **State management: decided — keep `flutter_bloc`/`Cubit`.** This fork already has 15+ global blocs wired in `main.dart` plus feature-local blocs/cubits across every existing feature; migrating to GetX would mean rewriting all of it for zero functional benefit. See Section 5.5 and `DECISIONS.md`.

### 4.7 Success Criteria
- All "High priority" features from Section 3 implemented and offline-verified (airplane mode test).
- Zero network calls required for prayer times, Quran reading, Duas, or Hijri calendar.
- App builds cleanly on current stable Flutter SDK with no deprecated API warnings.
- Codebase passes a Clean Architecture audit: no direct data-layer imports in presentation layer, all repositories accessed via interfaces.
- Bangla localization covers 100% of user-facing strings.

---

## 5. Clean Architecture Migration Plan

### 5.1 Proposed Folder Structure (Feature-First + Clean Architecture)

```
lib/
├── core/
│   ├── constants/
│   ├── error/                    # Failure & Exception classes
│   ├── network/                  # (kept minimal — only for optional future sync)
│   ├── theme/
│   ├── localization/
│   ├── di/                       # dependency injection setup
│   ├── routing/                  # app router / navigation
│   ├── utils/
│   └── widgets/                  # shared/reusable widgets
│
├── features/
│   ├── prayer_times/
│   │   ├── data/
│   │   │   ├── datasources/      # local: adhan_dart wrapper, location service
│   │   │   ├── models/
│   │   │   └── repositories/     # implementation
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/     # abstract interfaces
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/             # Bloc or Cubit — see DECISIONS.md
│   │       ├── screens/
│   │       └── widgets/
│   │
│   ├── quran/
│   │   ├── data/ (local Quran DB, tafsir JSON, audio datasource)
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── dua_azkar/
│   ├── tasbih/
│   ├── hijri_calendar/
│   ├── ramadan/
│   ├── qibla/
│   ├── hadith/
│   └── settings/                 # language, theme, notification prefs
│
├── app.dart
└── main.dart
```

### 5.2 Domain, Data, and Presentation Layers

- **Domain layer** (pure Dart, no Flutter imports): Entities (e.g. `PrayerTime`, `Surah`, `Dua`), abstract repository interfaces, use cases (e.g. `GetTodayPrayerTimes`, `GetSurahById`, `ToggleDuaFavorite`). This layer has zero dependency on `data` or `presentation` — it defines contracts only.
- **Data layer**: Implements domain repository interfaces. Contains data sources (local: `adhan_dart` calculations, bundled Quran JSON/SQLite, Hive boxes for bookmarks/favorites) and models that map to/from domain entities.
- **Presentation layer**: Widgets, screens, and state management (Bloc/Cubit) that call use cases — never data sources directly.

### 5.3 Repository Interfaces and Implementations

Example for prayer times:

```dart
// domain/repositories/prayer_repository.dart
abstract class PrayerRepository {
  Future<Either<Failure, DailyPrayerTimes>> getPrayerTimes(Coordinates coords, DateTime date);
  Future<Either<Failure, void>> setPrayerAlarmEnabled(Prayer prayer, bool enabled);
}

// data/repositories/prayer_repository_impl.dart
class PrayerRepositoryImpl implements PrayerRepository {
  final AdhanLocalDataSource localDataSource;
  PrayerRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, DailyPrayerTimes>> getPrayerTimes(Coordinates coords, DateTime date) async {
    try {
      final result = localDataSource.calculate(coords, date);
      return Right(result.toEntity());
    } catch (e) {
      return Left(CalculationFailure(e.toString()));
    }
  }
  // ...
}
```

Apply the same pattern for `QuranRepository`, `DuaRepository`, `HijriRepository`, etc. — every feature module gets its own repository interface + implementation pair.

### 5.4 Dependency Injection Strategy

- Use `get_it` + `injectable` (code-gen based) for DI registration — lightweight, no Flutter widget tree coupling, works well with Bloc.
- Register per-feature: data sources → repositories → use cases → blocs/cubits, each in a `feature_injection.dart` file inside that feature's folder, aggregated in `core/di/injection_container.dart`.
- Lazy-singleton repositories and data sources; factory for use cases and presentation blocs/cubits.

### 5.5 State Management — Decided: `flutter_bloc`

**Locked decision (2026-07-19, see `DECISIONS.md`): keep `flutter_bloc`/`Cubit`, do not migrate to GetX.**

Rationale: this fork already has state management fully built out on Bloc — 15+ global blocs wired in `MultiBlocProvider` in `main.dart`, plus feature-local blocs/cubits in every existing feature folder. A GetX migration would mean rewriting all of it purely for portfolio consistency with other projects (Onkur, FlexWork, Shell Agami), at the cost of real regression risk across the entire app, for zero functional benefit here. New features in the Clean Architecture structure use Bloc/Cubit in `presentation/bloc/`, following the existing part-file convention (`x_bloc.dart` + `part 'x_event.dart'` + `part 'x_state.dart'`) already established in this codebase.

### 5.6 Navigation Structure
- Centralize routes in `core/routing/app_router.dart` using named routes (or `go_router` for deep-linking support, e.g. opening directly to a specific Dua category from a notification tap).
- Each feature exposes its own route constants (e.g. `QuranRoutes.surahDetail`) to avoid a single bloated route file.

### 5.7 Shared Core Modules
- `core/theme`: `ThemeBloc` (already exists — migrate as-is into new structure).
- `core/localization`: `.arb` files for English + Bangla, `AppLocalizations` wrapper.
- `core/widgets`: shared components (prayer time card, section headers, empty states).
- `core/notifications`: centralized local notification scheduling service, used by both Azan alarms and daily reminder features — build once, consume from multiple features.

### 5.8 Migration Strategy — Incremental Phases

1. **Phase 0 — Stabilize:** Upgrade Flutter SDK and all dependencies on the existing codebase first, fix build-breaking issues, get CI green. Do this before any architectural change.
2. **Phase 1 — Scaffold new structure:** Create the `core/` and `features/` folder skeleton alongside the existing code (no deletion yet).
3. **Phase 2 — Migrate one feature at a time**, starting with the simplest (Qibla), to validate the pattern before tackling Quran (largest/most complex):
   Qibla → Tasbih (new) → Hijri Calendar (new) → Prayer Times (replace API with `adhan_dart`) → Dua/Azkar (new) → Hadith → Quran.
4. **Phase 3 — Remove legacy code** once each feature's new implementation is verified in a build, screen-by-screen.
5. **Phase 4 — New feature buildout** (Ramadan tools, Bangla localization, notifications) on top of the now-clean structure.

### 5.9 Risks and Mitigation

| Risk | Mitigation |
|---|---|
| Dependency upgrade breaks existing UI | Do Phase 0 in an isolated branch with full manual QA pass before merging |
| Migrating Quran module (largest) introduces regressions | Migrate last, after the pattern is proven on smaller features |
| Azan notification reliability on Android (Doze mode, OEM battery killers) | Use `flutter_local_notifications` with exact alarms + guide users to disable battery optimization (as competitor apps do) |
| Scope creep from BRD's full feature list vs. developer bandwidth | Strictly follow High → Medium → Low priority order from Section 3; do not start Medium items before High is done |

### 5.10 Best Practices for Scalability, Maintainability, Testability
- One feature = one folder with its own data/domain/presentation — no cross-feature imports except through `core/`.
- Domain layer has zero Flutter/package imports — enables fast unit tests with no widget bindings.
- All repository access goes through interfaces — enables mocking in tests via `mocktail`/`mockito`.
- Keep use cases single-responsibility (one class, one method, e.g. `GetTodayPrayerTimes`) rather than fat repositories called directly from UI.
- Enforce via lint rule or PR checklist: presentation layer never imports anything from `data/`.

---

## 6. Implementation Roadmap with Priorities and Milestones

| Milestone | Contents | Priority | Est. effort |
|---|---|---|---|
| **M0 — Stabilize** | Flutter/dependency upgrade, fix broken build, CI green | Prerequisite | 3-5 days |
| **M1 — Architecture scaffold** | New folder structure, DI setup, migrate Qibla + Theme as proof of pattern | High | 5-7 days |
| **M2 — Offline prayer core** | Replace API with `adhan_dart`, countdown UI, Azan alarm + toggle, voluntary prayer times | High | 10-14 days |
| **M3 — Worship essentials** | Dua/Azkar module, Tasbih counter, Hijri calendar | High | 10-12 days |
| **M4 — Localization** | Bangla `.arb` translation, language switcher | High | 5-7 days |
| **M5 — Ramadan tools** | Suhoor/Iftar/Imsak countdowns, voluntary fasting reminders | Medium | 5-7 days |
| **M6 — Quran enhancement** | Migrate Quran module, add Tafsir, audio recitation, bookmarks | Medium | 12-15 days |
| **M7 — Extras** | 99 Names, Zakat calculator, daily reminder notifications | Low | 5-7 days |
| **M8 — Polish** | Home-screen widgets, Mosque finder (if still desired), Hajj/Umrah guide content | Low | Variable |

**Total estimated core buildout (M0–M5): ~6-7 weeks** at steady solo-developer pace, before optional Quran/extras milestones.

---

*Next step: if useful, this can be converted into a per-feature agent prompt (matching your `AGENT_PROMPT.md` pattern used on FlexWork/Onkur) to drive implementation with an analysis-first, confirmation-gated workflow. See `AMAR_DEEN_AGENT_PROMPT.md`.*
