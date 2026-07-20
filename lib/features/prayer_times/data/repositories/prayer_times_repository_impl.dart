import 'package:injectable/injectable.dart';

import '../../domain/entities/prayer_calculation_method.dart';
import '../../domain/entities/prayer_times_entity.dart';
import '../../domain/entities/voluntary_prayer_times_entity.dart';
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

  @override
  VoluntaryPrayerTimesEntity getVoluntaryPrayerTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
    required PrayerCalculationMethod method,
    required PrayerMadhab madhab,
  }) {
    final result = localDataSource.getVoluntaryTimes(
      latitude: latitude,
      longitude: longitude,
      date: date,
      method: method,
      madhab: madhab,
    );

    // Ishraq/Duha have no single calculation-engine-provided value (unlike
    // the obligatory prayers or Tahajjud's SunnahTimes) - these are
    // commonly-cited approximations: Ishraq ~20 minutes after sunrise,
    // Duha's window running from there until 10 minutes before Dhuhr
    // (Zawal). See VoluntaryPrayerTimesEntity's doc comment.
    final ishraq = result.prayerTimes.sunrise.add(const Duration(minutes: 20));

    return VoluntaryPrayerTimesEntity(
      ishraq: ishraq,
      duhaStart: ishraq,
      duhaEnd: result.prayerTimes.dhuhr.subtract(const Duration(minutes: 10)),
      tahajjudStart: result.sunnahTimes.lastThirdOfTheNight,
      tahajjudEnd: result.nextDayFajr,
    );
  }
}
