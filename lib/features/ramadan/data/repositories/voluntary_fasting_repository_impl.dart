import 'package:hijri_calendar/hijri_calendar.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/voluntary_fasting_day.dart';
import '../../domain/repositories/voluntary_fasting_repository.dart';

@LazySingleton(as: VoluntaryFastingRepository)
class VoluntaryFastingRepositoryImpl implements VoluntaryFastingRepository {
  const VoluntaryFastingRepositoryImpl();

  /// Reminder fires at 8pm the evening before each fasting day.
  static const int _reminderHour = 20;

  /// A full Hijri year is ~354 days; 400 comfortably covers "just missed
  /// this occurrence, next one is nearly a full year away" (Arafah, which
  /// only happens once a year, is the worst case).
  static const int _maxDaysAhead = 400;

  /// (Hijri day-of-month, Hijri month) for a Gregorian [date], read via
  /// `HijriCalendarConfig.toFormat()`'s numeric tokens rather than reading
  /// instance fields directly - `toFormat` is the only part of this
  /// package's API already proven to work in this codebase (see
  /// `date_controller.dart`'s `getIslamicDate`), and this environment has
  /// no `flutter`/`dart` binary to verify field names against the actual
  /// installed package version another way.
  ({int day, int month}) _hijriDayMonth(DateTime date) {
    final hijri = HijriCalendarConfig.fromGregorian(date);
    return (
      day: int.parse(hijri.toFormat('dd')),
      month: int.parse(hijri.toFormat('MM')),
    );
  }

  DateTime _reminderMomentFor(DateTime fastDay) {
    return DateTime(fastDay.year, fastDay.month, fastDay.day)
        .subtract(const Duration(days: 1))
        .add(const Duration(hours: _reminderHour));
  }

  /// Walks forward day-by-day from today until [matches] is true AND the
  /// resulting reminder moment (the evening before) is still in the
  /// future - so a fasting day that's already started today is skipped in
  /// favor of its next occurrence, rather than producing a reminder for a
  /// moment that already passed.
  VoluntaryFastingDay? _searchNext({
    required DateTime now,
    required VoluntaryFastingType type,
    required bool Function(DateTime candidate) matches,
  }) {
    final today = DateTime(now.year, now.month, now.day);
    for (var i = 0; i <= _maxDaysAhead; i++) {
      final candidate = today.add(Duration(days: i));
      if (!matches(candidate)) continue;

      final reminderAt = _reminderMomentFor(candidate);
      if (!reminderAt.isAfter(now)) continue;

      return VoluntaryFastingDay(
        type: type,
        date: candidate,
        reminderAt: reminderAt,
      );
    }
    return null;
  }

  @override
  List<VoluntaryFastingDay> getUpcomingFastingDays({required DateTime now}) {
    final results = <VoluntaryFastingDay>[];

    final monday = _searchNext(
      now: now,
      type: VoluntaryFastingType.monday,
      matches: (d) => d.weekday == DateTime.monday,
    );
    if (monday != null) results.add(monday);

    final thursday = _searchNext(
      now: now,
      type: VoluntaryFastingType.thursday,
      matches: (d) => d.weekday == DateTime.thursday,
    );
    if (thursday != null) results.add(thursday);

    // Ayyam al-Beed - the "White Days", 13th-15th of every Hijri month.
    // A single reminder for the 13th (the first day) covers the block;
    // this doesn't require Dhul Hijjah/any specific month, it recurs
    // every Hijri month.
    final ayyamAlBeed = _searchNext(
      now: now,
      type: VoluntaryFastingType.ayyamAlBeed,
      matches: (d) => _hijriDayMonth(d).day == 13,
    );
    if (ayyamAlBeed != null) results.add(ayyamAlBeed);

    // Day of Arafah - 9th of Dhul Hijjah, the 12th Hijri month.
    final arafah = _searchNext(
      now: now,
      type: VoluntaryFastingType.arafah,
      matches: (d) {
        final hijriDayMonth = _hijriDayMonth(d);
        return hijriDayMonth.day == 9 && hijriDayMonth.month == 12;
      },
    );
    if (arafah != null) results.add(arafah);

    results.sort((a, b) => a.date.compareTo(b.date));
    return results;
  }
}
