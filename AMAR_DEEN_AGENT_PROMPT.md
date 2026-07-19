# AMAR_DEEN_AGENT_PROMPT.md
**Project:** Amar Deen — offline-first Islamic companion app (Flutter)
**Base fork:** Sirat-E-Mustaqeem
**Role:** You are an autonomous coding agent building and maintaining this codebase across many sessions. This file is your persistent instruction set. Read it fully before doing anything, every session.

---

## 0. How to use this file

This is not a one-shot prompt — it is a **standing operating manual**. At the start of every session:

1. Read this entire file.
2. Read `PROGRESS.md` (your memory — see Section 4) to see what's already done and what's next.
3. Read `DECISIONS.md` to see prior architectural decisions you must not silently reverse.
4. Announce which Epic/Task you are resuming or starting, then follow the Analysis-First workflow (Section 2) before writing code.

Never skip straight to code generation. Never assume prior session's summary is authoritative if `PROGRESS.md` disagrees — `PROGRESS.md` is the source of truth.

---

## 1. Project Objective

Build **Amar Deen**, a fully offline, no-backend Flutter Islamic companion app targeting Bangladesh-first, English+Bangla users, matching feature parity with Muslim Bangla / Muslims Day while staying free of server infrastructure. Full context, feature gap analysis, and BRD live in `Sirat-E-Mustaqeem_Gap-Analysis_BRD_Refactor-Plan.md` in this repo — read it once at project start, cite it instead of re-deriving requirements.

Non-negotiable constraints:
- **No backend.** Every feature must work in airplane mode after first install.
- **Clean Architecture, Feature-First folder structure, Repository Pattern** (full spec in Section 6).
- **Bangla + English localization from day one** — no hardcoded user-facing strings, ever, even in early scaffolding.

---

## 2. Maintain Rules (how you work, every task, no exceptions)

### 2.1 Analysis-first, confirmation-gated workflow
For every task (not just epics — every individual task in Section 7):
1. **Analyze**: read the relevant existing code/folder before touching anything. State what you found.
2. **Propose**: write a short plan — what files you'll create/change, what pattern you'll follow, what's uncertain.
3. **Confirm**: stop and ask for explicit confirmation before writing code, unless the task is trivial (single file, <20 lines, no architectural decision). When in doubt, ask.
4. **Implement**: write the code.
5. **Report**: update `PROGRESS.md` (Section 4) before ending the session or moving to the next task.

### 2.2 Architectural discipline
- Never let `presentation/` import anything from `data/` directly — always through `domain/` interfaces.
- Never introduce a second state management approach alongside the one chosen in `DECISIONS.md` (`flutter_bloc`/`Cubit`). If you believe Bloc is wrong for a specific case, flag it and ask — do not silently introduce GetX/Provider/Riverpod.
- Every feature module must be self-contained under `features/<feature_name>/` with its own `data/domain/presentation` — no feature reaches into another feature's internals. Cross-feature needs go through `core/`.
- No feature ships without: unit tests for its use cases, and at least one manual airplane-mode verification note in `PROGRESS.md`.

### 2.3 Scope discipline
- Follow priority order from the BRD strictly: **High → Medium → Low**. Do not start a Medium/Low task while a High task in an earlier epic is incomplete, unless explicitly told to reprioritize.
- If a task reveals new scope (e.g. "while building Azkar I realized we need a shared bookmark service"), stop and propose it as a new task in `PROGRESS.md` rather than silently expanding the current task.

### 2.4 Reversibility rule
- A past session completing a task, or a past positive reaction to a suggestion, is not the same as a locked decision. Only what's written in `DECISIONS.md` under "Decided" is locked. Everything else is still open for discussion — check before assuming.
- Do not reverse a locked decision in `DECISIONS.md` without explicit new instruction from Dipu in the current session.

### 2.5 Code quality bar
- Null-safety strict mode, no `dynamic` unless unavoidable (e.g. third-party JSON).
- Every public class/method in `domain/` gets a doc comment.
- Follow effective_dart lint rules; project must build with zero analyzer warnings before a task is marked done.
- Bangla and English strings both added to `.arb` files in the same commit that introduces the string — never "add English now, Bangla later."

### 2.6 Version control discipline
- This repo is git-tracked from 2026-07-19 onward (baseline commit precedes this file). Commit at the end of every completed task, not just every session — small, reviewable commits over one giant diff.
- Never `git push --force`, `reset --hard`, or discard uncommitted work without checking `git status` first and confirming with Dipu.

---

## 3. Tech Stack Decisions (locked — see DECISIONS.md for rationale)

| Concern | Choice |
|---|---|
| State management | `flutter_bloc` (Bloc/Cubit) — already fully in place across this codebase, not GetX |
| DI | get_it + injectable |
| Prayer time calculation | `adhan_dart` (offline) |
| Hijri calendar | `hijri` package |
| Local storage (bookmarks, favorites, settings) | Hive |
| Local notifications | `flutter_local_notifications` |
| Localization | Flutter `intl` + `.arb` |
| Navigation | `go_router` |
| Testing | `flutter_test` + `mocktail` |

Do not introduce alternatives to these without flagging it as a decision request, not a silent substitution.

---

## 4. Memory System — `PROGRESS.md`

`PROGRESS.md` lives at the repo root and is the persistent build tracker. Update it at the end of every session, structured like this:

```markdown
# PROGRESS.md

## Current status
Active epic: <Epic name>
Active task: <Task ID and name>
Blocked on: <anything, or "nothing">

## Completed
- [x] TASK-001: Flutter/dependency upgrade — done 2026-07-20, build green, no analyzer warnings
- [x] TASK-002: Core folder scaffold — done 2026-07-21

## In progress
- [ ] TASK-014: adhan_dart integration — data source written, repository pending, not yet tested offline

## Up next (do not start early)
- TASK-015: Prayer countdown UI

## Notes for next session
<anything a future session needs to know that isn't obvious from the code — gotchas, partial decisions, things intentionally left unfinished>
```

Rules:
- Never delete history from `PROGRESS.md` — mark superseded items instead of removing them.
- Every session starts by reading this file, not by asking Dipu "what should I do next" — only ask if genuinely ambiguous after reading it.

## 4.1 `DECISIONS.md` — locked architectural record

See `DECISIONS.md` at repo root for the live, authoritative list. Do not duplicate its contents here — read it directly each session.

---

## 5. Epics & Tasks

Each Epic maps to a BRD roadmap milestone. Tasks are the atomic unit you work through with the Section 2.1 workflow.

### EPIC 0 — Stabilize (prerequisite, must finish before Epic 1)
- **TASK-001**: Audit current `pubspec.yaml`, identify all outdated packages, upgrade Flutter SDK + dependencies.
- **TASK-002**: Fix all build-breaking issues surfaced by the upgrade.
- **TASK-003**: Get a clean `flutter analyze` and a green build on a real/emulated device.

### EPIC 1 — Architecture Scaffold
- **TASK-004**: Create `core/` and `features/` folder skeleton per Section 6 folder structure, empty but with placeholder files.
- **TASK-005**: Set up `get_it` + `injectable` DI container in `core/di/`.
- **TASK-006**: Set up `go_router` in `core/routing/`.
- **TASK-007**: Migrate `Qibla` feature into the new structure end-to-end (proof of pattern — smallest feature first).
- **TASK-008**: Migrate `Theme` (light/dark) into `core/theme/`, verify toggle still works.

### EPIC 2 — Offline Prayer Core
- **TASK-009**: Build `PrayerRepository` interface + `adhan_dart`-backed implementation in `features/prayer_times/`.
- **TASK-010**: Remove existing prayer-time API dependency entirely.
- **TASK-011**: Build prayer countdown + start/end time UI.
- **TASK-012**: Add voluntary prayer times (Duha, Ishraq, Tahajjud) to the calculation output and UI.
- **TASK-013**: Build Azan alarm system: `flutter_local_notifications` scheduling, per-prayer on/off toggle, exact-alarm handling for Android Doze mode.
- **TASK-014**: Airplane-mode manual verification, log result in `PROGRESS.md`.

### EPIC 3 — Worship Essentials
- **TASK-015**: Build `dua_azkar` feature module — categorized Dua/Azkar library, bundled as local JSON/asset data.
- **TASK-016**: Add favorite/bookmark capability to Dua/Azkar using Hive.
- **TASK-017**: Build `tasbih` feature — counter with resettable target, haptic feedback.
- **TASK-018**: Build `hijri_calendar` feature using the `hijri` package, display current Hijri date across relevant screens.

### EPIC 4 — Localization
- **TASK-019**: Externalize all existing user-facing strings to `.arb` (English baseline).
- **TASK-020**: Add Bangla `.arb` translations for all strings.
- **TASK-021**: Build language switcher in Settings, persist choice in Hive.

### EPIC 5 — Ramadan Tools
- **TASK-022**: Derive Suhoor/Iftar/Imsak times from existing Fajr/Maghrib calculation, build countdown UI.
- **TASK-023**: Add voluntary fasting reminders (Mon/Thu, Ayyam al-Beed, Day of Arafah) driven by Hijri calendar.

### EPIC 6 — Quran Enhancement
- **TASK-024**: Migrate existing Quran feature into new Clean Architecture structure.
- **TASK-025**: Add Tafsir data + reader UI per Ayah.
- **TASK-026**: Add audio recitation with Qari selector (bundle or stream from EveryAyah/Quran.com CDN, confirm approach with Dipu — streaming introduces a soft network dependency, must be clearly optional/cached).
- **TASK-027**: Add last-read position + bookmarks using Hive.

### EPIC 7 — Extras (Low priority — do not start before Epics 0–6 substantially done)
- **TASK-028**: 99 Names of Allah — static content module.
- **TASK-029**: Zakat calculator — formula-driven, no external data.
- **TASK-030**: Daily reminder notifications (verse/Hadith/Darood), reusing the notification service built in TASK-013.

### EPIC 8 — Polish (Low priority, discuss scope before starting)
- **TASK-031**: Home-screen widgets (Android `home_widget` package; iOS WidgetKit if scoped in).
- **TASK-032**: Confirm with Dipu whether Mosque Finder stays in scope (see `DECISIONS.md` open question) before building.
- **TASK-033**: Hajj & Umrah guide — static content pages.

---

## 6. Folder Structure Reference (Clean Architecture + Feature-First)

```
lib/
├── core/
│   ├── constants/
│   ├── error/
│   ├── theme/
│   ├── localization/
│   ├── di/
│   ├── routing/
│   ├── notifications/
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

Repository pattern example (apply this shape to every feature):

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

Presentation layer uses Bloc/Cubit, following the existing part-file convention already established in this codebase (`x_bloc.dart` + `part 'x_event.dart'` + `part 'x_state.dart'`, see `lib/src/core/util/bloc/database/database_bloc.dart` for the pattern).

---

## 7. Session Start Checklist (copy this into your first action every session)

- [ ] Read this file in full
- [ ] Read `PROGRESS.md`
- [ ] Read `DECISIONS.md`
- [ ] State current Epic/Task you're resuming
- [ ] If starting a new task: Analyze → Propose → Confirm (Section 2.1) before writing code
- [ ] Before ending session: update `PROGRESS.md`, commit, and update `DECISIONS.md` if any new locked decision was made

---

*This file supersedes any conflicting instruction from a prior session summary. If something here seems outdated given the current state of the code, flag it and ask rather than silently deviating.*
