import 'package:injectable/injectable.dart';

import '../entities/prayer_calculation_method.dart';
import '../entities/voluntary_prayer_times_entity.dart';
import '../repositories/prayer_times_repository.dart';

/// Computes Ishraq, Duha, and Tahajjud windows for a given location/date.
@injectable
class GetVoluntaryPrayerTimes {
  final PrayerTimesRepository repository;

  const GetVoluntaryPrayerTimes(this.repository);

  VoluntaryPrayerTimesEntity call({
    required double latitude,
    required double longitude,
    required DateTime date,
    required PrayerCalculationMethod method,
    required PrayerMadhab madhab,
  }) {
    return repository.getVoluntaryPrayerTimes(
      latitude: latitude,
      longitude: longitude,
      date: date,
      method: method,
      madhab: madhab,
    );
  }
}
