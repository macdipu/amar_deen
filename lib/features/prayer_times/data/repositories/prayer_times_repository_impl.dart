import 'package:injectable/injectable.dart';

import '../../domain/entities/prayer_calculation_method.dart';
import '../../domain/entities/prayer_times_entity.dart';
import '../../domain/repositories/prayer_times_repository.dart';
import '../datasources/adhan_local_data_source.dart';

@LazySingleton(as: PrayerTimesRepository)
class PrayerTimesRepositoryImpl implements PrayerTimesRepository {
  final AdhanLocalDataSource localDataSource;

  const PrayerTimesRepositoryImpl(this.localDataSource);

  @override
  PrayerTimesEntity getPrayerTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
    required PrayerCalculationMethod method,
    required PrayerMadhab madhab,
  }) {
    final prayerTimes = localDataSource.getPrayerTimes(
      latitude: latitude,
      longitude: longitude,
      date: date,
      method: method,
      madhab: madhab,
    );

    return PrayerTimesEntity(
      fajr: prayerTimes.fajr,
      sunrise: prayerTimes.sunrise,
      dhuhr: prayerTimes.dhuhr,
      asr: prayerTimes.asr,
      maghrib: prayerTimes.maghrib,
      isha: prayerTimes.isha,
    );
  }
}
