# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Flutter app `amar_deen` ("Amar Deen") — an Islamic companion app (Quran, prayer timings, Qibla, Azkar, Tasbih, Duas, Live TV, Allah's Names). Android minSdk 16 / target 30 / compileSdk 33, iOS platform 15.0.

**Note on `rules.md`:** the root `rules.md` describes a *different* sibling project (`user_app`, GetX + Clean Architecture with `data/domain/presentation` layers and a `generate_feature.dart` scaffolder). This repo does **not** use GetX and has no such generator — it's built on `flutter_bloc`/`hydrated_bloc` with a flatter structure (see Architecture below). Do not apply `rules.md`'s GetX/UseCase/Repository-generator conventions here; use the patterns actually present in this codebase instead.

## Commands

- Run: `flutter run`
- Test: `flutter test` (single file: `flutter test test/widget_test.dart`)
- Analyze: `flutter analyze`
- Format: `dart format .`
- Pub get: `flutter pub get`
- Build Android: `flutter build apk --release`
- Build iOS: `flutter build ipa`

Run `flutter analyze` after edits to catch errors before reporting done.

## Architecture

State management is **flutter_bloc** (Bloc for event-driven state, Cubit for simpler state) plus **hydrated_bloc** for state that persists to disk automatically (e.g. `ThemeBloc`, `TimeFormatBloc`). There is no GetX, no dependency-injection container, and no UseCase/Repository code-generator in this repo.

### Two tiers of Bloc/Cubit

1. **App-level (global) blocs** — `lib/src/core/util/bloc/<name>/`. Each is `bloc.dart` + `event.dart` + `state.dart` combined via `part`/`part of`. All of these are constructed once in `MultiBlocProvider` in `lib/main.dart` and are available app-wide via `context.read<XBloc>()` / `BlocBuilder<XBloc, XState>`. Examples: `ThemeBloc`, `TimeFormatBloc`, `DatabaseBloc`, `LocationBloc`, `TimingBloc` (prayer timing), `PrayerTimeConfigBloc`, `QuranBloc`, `QuranAudioBloc`, `SurahBloc`, `JuzBloc`, `TasbihBloc`, `DuaBloc`, `AllahNameBloc`, `NotificationBloc`, `TabBloc`.
2. **Feature-local blocs/cubits** — `lib/src/features/<feature>/{bloc,cubit,controller}/`, scoped to that feature's screens only (not provided globally). Naming and event/state-in-`part` convention matches the global blocs.

Blocs generally call a service or repository directly inside the event handler (`on<Event>((event, emit) async { ... })`) rather than going through a UseCase layer — e.g. `DatabaseBloc` calls `DatabaseService().initService(...)` directly (`lib/src/core/util/bloc/database/database_bloc.dart`). Some features add a thin `Repository` wrapper around a third-party package (e.g. `lib/src/features/azkar/repository/azkar_repository.dart` wraps `MuslimRepository` from the `muslim_data_flutter` package) — follow that pattern when a feature needs to isolate a third-party data source, but don't introduce a full Data/Domain/Presentation split; it doesn't exist elsewhere in this codebase.

### Core module (`lib/src/core/`)

- `database/` — `DatabaseService` (singleton-style class, not injected) owns the bundled SQLite DB (`assets/latest.db`, copied to app storage on first run / on asset-size mismatch) and all raw SQL for `quran`, `tasbih`, `dua`, and a `quran_favourites` table it manages itself (create-if-missing, migrate-and-preserve-favourites on DB replacement). Returns `Either<LocalFailure, T>` (dartz) from `initService`, but most other methods just return raw `List<Map<String, Object?>>` — no DTO/entity mapping layer for DB reads.
- `network/` — `NetworkClient` (thin Dio wrapper: get/post/patch/download, throws `RemoteException` on `DioException`) and `api_service.dart`.
- `error/` — `Failure`/`LocalFailure` (dartz `Either` left side), `Exceptions` (`LocalException`, `RemoteException`), `error_code.dart` (error code/message constants like `kReadDatabaseFailed`).
- `notification/` — `NotificationService` (init'd in `main()` before `runApp`) and `receive_notification.dart`, backed by `flutter_local_notifications`.
- `util/controller/` — plain (non-Bloc) helper classes: `LocationController`, `TimingController`, `DateController`, `ShareController`, `NotificationController`, `UrlLauncherController`.
- `util/model/` — plain Dart models shared across features (`Quran`, `Surah`, `Juz`, `Dua`, `Tasbih`, `Timing`, `Geocoding`).
- `util/theme.dart`, `util/constants.dart` — app theme and shared constants (e.g. `DATABASE_FILE`).

### Routing

Manual route table in `lib/routes/routes.dart` — `RouteGenerator` holds route-name string constants and a `generateRoute(RouteSettings)` switch returning `MaterialPageRoute`s. No named-route generator/codegen; add new screens by adding a constant + a `case` here.

### App startup (`lib/main.dart`)

`main()` initializes bindings, notification service, and `HydratedBloc.storage` (documents directory) before `runApp`. `MyApp` wraps everything in a single `MultiBlocProvider` (all global blocs listed above) → `ScreenUtilInit` (design size 414x896) → `BlocBuilder<ThemeBloc, ThemeState>` supplying `MaterialApp.theme` → `onGenerateRoute: RouteGenerator.generateRoute`, starting at `SplashScreen`.

### Feature list

`lib/src/features/`: `allah_name`, `azkar`, `bookmark`, `bottom_tab`, `dua`, `error`, `home`, `live_tv`, `permission`, `prayer_timing`, `qibla`, `quran` (largest — has its own `audio/` subfolder for the Quran audio player catalog), `search`, `setting`, `splash`, `tasbih`, `utils`. Each typically has `screen/` + `widget/` + one or more of `bloc/`, `cubit/`, `controller/`.

## Conventions

- No hardcoded colors/text styles in feature/widget code — use the shared `theme.dart`/`constants.dart` and existing `core/util/widgets/` (e.g. `elevated_button.dart`) rather than duplicating.
- Event/state classes live in the same directory as their bloc/cubit, joined via `part 'x_event.dart'; part 'x_state.dart';` — follow this when adding a new bloc rather than putting them in separate folders.
- `Either<Failure, T>` (dartz) is the pattern for operations that can fail at the service boundary (DB init, network); plain returns are fine for simple synchronous-feeling DB reads elsewhere in `DatabaseService`.
