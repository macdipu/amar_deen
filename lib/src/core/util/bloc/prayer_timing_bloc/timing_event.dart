part of 'timing_bloc.dart';

abstract class TimingEvent extends Equatable {
  const TimingEvent();
}

class RequestTiming extends TimingEvent {
  final LocationState locationState;

  final PermissionStatus notificationEnabled;
  final PrayerCalculationMethod method;
  final PrayerMadhab madhab;
  final int dayOffset;
  final int hijriAdjustmentDays;

  const RequestTiming(
    this.notificationEnabled,
    this.locationState,
    this.method,
    this.madhab,
    this.dayOffset,
    this.hijriAdjustmentDays,
  );

  @override
  List<Object> get props => [
        notificationEnabled,
        locationState,
        method,
        madhab,
        dayOffset,
        hijriAdjustmentDays,
      ];
}

class UpdateTiming extends TimingEvent {
  @override
  List<Object> get props => [];
}
