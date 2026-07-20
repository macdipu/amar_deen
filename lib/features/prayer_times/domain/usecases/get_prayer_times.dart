import 'package:injectable/injectable.dart';

import '../entities/prayer_calculation_method.dart';
import '../entities/prayer_times_entity.dart';
import '../repositories/prayer_times_repository.dart';

/// Computes a single day's prayer times for a given location/date/method.
@injectable
class GetPrayerTimes {
  final PrayerTimesRepository repository;

  const GetPrayerTimes(this.repository);

  PrayerTimesEntity call({
    required double latitude,
    required double longitude,
    required DateTime date,
    required PrayerCalculationMethod method,
    required PrayerMadhab madhab,
  }) {
    return repository.getPrayerTimes(
      latitude: latitude,
      longitude: longitude,
      date: date,
      method: method,
      madhab: madhab,
    );
  }
}
