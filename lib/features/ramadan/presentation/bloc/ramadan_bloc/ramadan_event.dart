part of 'ramadan_bloc.dart';

abstract class RamadanEvent extends Equatable {
  const RamadanEvent();
}

class RequestRamadanTimes extends RamadanEvent {
  final LocationState locationState;
  final PrayerCalculationMethod method;
  final PrayerMadhab madhab;
  final int dayOffset;

  const RequestRamadanTimes(
    this.locationState,
    this.method,
    this.madhab,
    this.dayOffset,
  );

  @override
  List<Object> get props => [locationState, method, madhab, dayOffset];
}
