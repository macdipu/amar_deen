part of 'voluntary_prayer_bloc.dart';

abstract class VoluntaryPrayerEvent extends Equatable {
  const VoluntaryPrayerEvent();
}

class RequestVoluntaryPrayerTimes extends VoluntaryPrayerEvent {
  final LocationState locationState;
  final PrayerCalculationMethod method;
  final PrayerMadhab madhab;
  final int dayOffset;

  const RequestVoluntaryPrayerTimes(
    this.locationState,
    this.method,
    this.madhab,
    this.dayOffset,
  );

  @override
  List<Object> get props => [locationState, method, madhab, dayOffset];
}
