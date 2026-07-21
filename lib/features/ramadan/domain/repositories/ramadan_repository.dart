import '../../../prayer_times/domain/entities/prayer_calculation_method.dart';
import '../entities/ramadan_times_entity.dart';

/// Computes Ramadan Suhoor/Iftar times entirely on-device - no network
/// access, no server round-trip, works in airplane mode.
abstract class RamadanRepository {
  RamadanTimesEntity getRamadanTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
    required PrayerCalculationMethod method,
    required PrayerMadhab madhab,
  });
}
