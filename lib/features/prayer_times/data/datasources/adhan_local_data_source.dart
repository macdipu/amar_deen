import 'package:adhan_dart/adhan_dart.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/prayer_calculation_method.dart';

/// Wraps the `adhan_dart` package, which computes prayer times purely
/// on-device from geographic coordinates, a date, and a calculation
/// method - no network access.
abstract class AdhanLocalDataSource {
  PrayerTimes getPrayerTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
    required PrayerCalculationMethod method,
    required PrayerMadhab madhab,
  });

  /// [PrayerTimes] plus its [SunnahTimes] (middle/last third of the
  /// night) and the *next* day's Fajr - `SunnahTimes` internally computes
  /// tomorrow's Fajr to find "night" duration (Maghrib tonight to Fajr
  /// tomorrow) but doesn't expose it, and callers need it separately as
  /// the end of the Tahajjud window (today's Fajr has already passed by
  /// the time the last third of the night begins).
  ({PrayerTimes prayerTimes, SunnahTimes sunnahTimes, DateTime nextDayFajr})
      getVoluntaryTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
    required PrayerCalculationMethod method,
    required PrayerMadhab madhab,
  });
}

@LazySingleton(as: AdhanLocalDataSource)
class AdhanLocalDataSourceImpl implements AdhanLocalDataSource {
  const AdhanLocalDataSourceImpl();

  @override
  PrayerTimes getPrayerTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
    required PrayerCalculationMethod method,
    required PrayerMadhab madhab,
  }) {
    final calculationParameters = _calculationParametersFor(method)
      ..madhab = madhab == PrayerMadhab.hanafi ? Madhab.hanafi : Madhab.shafi;

    return PrayerTimes(
      coordinates: Coordinates(latitude, longitude),
      date: date,
      calculationParameters: calculationParameters,
      precision: true,
    );
  }

  @override
  ({PrayerTimes prayerTimes, SunnahTimes sunnahTimes, DateTime nextDayFajr})
      getVoluntaryTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
    required PrayerCalculationMethod method,
    required PrayerMadhab madhab,
  }) {
    final prayerTimes = getPrayerTimes(
      latitude: latitude,
      longitude: longitude,
      date: date,
      method: method,
      madhab: madhab,
    );
    final nextDayPrayerTimes = getPrayerTimes(
      latitude: latitude,
      longitude: longitude,
      date: date.add(const Duration(days: 1)),
      method: method,
      madhab: madhab,
    );

    return (
      prayerTimes: prayerTimes,
      sunnahTimes: SunnahTimes(prayerTimes),
      nextDayFajr: nextDayPrayerTimes.fajr,
    );
  }

  CalculationParameters _calculationParametersFor(
    PrayerCalculationMethod method,
  ) {
    switch (method) {
      case PrayerCalculationMethod.muslimWorldLeague:
        return CalculationMethodParameters.muslimWorldLeague();
      case PrayerCalculationMethod.northAmerica:
        return CalculationMethodParameters.northAmerica();
      case PrayerCalculationMethod.egyptian:
        return CalculationMethodParameters.egyptian();
      case PrayerCalculationMethod.ummAlQura:
        return CalculationMethodParameters.ummAlQura();
      case PrayerCalculationMethod.karachi:
        return CalculationMethodParameters.karachi();
      case PrayerCalculationMethod.tehran:
        return CalculationMethodParameters.tehran();
      case PrayerCalculationMethod.jafari:
        return CalculationMethodParameters.jafari();
    }
  }
}
