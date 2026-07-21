import 'package:injectable/injectable.dart';

import '../../../prayer_times/domain/entities/prayer_calculation_method.dart';
import '../../../prayer_times/domain/repositories/prayer_times_repository.dart';
import '../../domain/entities/ramadan_times_entity.dart';
import '../../domain/repositories/ramadan_repository.dart';

@LazySingleton(as: RamadanRepository)
class RamadanRepositoryImpl implements RamadanRepository {
  final PrayerTimesRepository prayerTimesRepository;

  const RamadanRepositoryImpl(this.prayerTimesRepository);

  @override
  RamadanTimesEntity getRamadanTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
    required PrayerCalculationMethod method,
    required PrayerMadhab madhab,
  }) {
    final prayerTimes = prayerTimesRepository.getPrayerTimes(
      latitude: latitude,
      longitude: longitude,
      date: date,
      method: method,
      madhab: madhab,
    );

    // Imsak has no single calculation-engine-provided value (adhan_dart
    // doesn't compute it) - the commonly-cited convention is Fajr minus a
    // short buffer, to stop eating slightly before the Fajr adhan itself.
    // Same content-precision judgment call as Ishraq/Duha's offsets in
    // VoluntaryPrayerTimesEntity - flagged for Dipu to confirm the exact
    // minute value if a different convention is preferred.
    final imsak = prayerTimes.fajr.subtract(const Duration(minutes: 10));

    return RamadanTimesEntity(
      imsak: imsak,
      iftar: prayerTimes.maghrib,
    );
  }
}
