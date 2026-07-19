import '../entities/prayer_calculation_method.dart';
import '../entities/prayer_times_entity.dart';

/// Computes prayer times entirely on-device - no network access, no
/// server round-trip, works in airplane mode.
abstract class PrayerTimesRepository {
  PrayerTimesEntity getPrayerTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
    required PrayerCalculationMethod method,
    required PrayerMadhab madhab,
  });
}
