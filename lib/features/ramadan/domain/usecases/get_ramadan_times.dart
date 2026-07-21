import 'package:injectable/injectable.dart';

import '../../../prayer_times/domain/entities/prayer_calculation_method.dart';
import '../entities/ramadan_times_entity.dart';
import '../repositories/ramadan_repository.dart';

/// Computes Imsak (Suhoor end) and Iftar times for a given location/date.
@injectable
class GetRamadanTimes {
  final RamadanRepository repository;

  const GetRamadanTimes(this.repository);

  RamadanTimesEntity call({
    required double latitude,
    required double longitude,
    required DateTime date,
    required PrayerCalculationMethod method,
    required PrayerMadhab madhab,
  }) {
    return repository.getRamadanTimes(
      latitude: latitude,
      longitude: longitude,
      date: date,
      method: method,
      madhab: madhab,
    );
  }
}
