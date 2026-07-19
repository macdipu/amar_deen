part of 'voluntary_prayer_bloc.dart';

abstract class VoluntaryPrayerState extends Equatable {
  const VoluntaryPrayerState();
}

class VoluntaryPrayerInitial extends VoluntaryPrayerState {
  @override
  List<Object> get props => [];
}

class VoluntaryPrayerLoading extends VoluntaryPrayerState {
  @override
  List<Object> get props => [];
}

class VoluntaryPrayerLoaded extends VoluntaryPrayerState {
  final VoluntaryPrayerTimesEntity voluntaryPrayerTimes;

  const VoluntaryPrayerLoaded(this.voluntaryPrayerTimes);

  @override
  List<Object> get props => [voluntaryPrayerTimes];
}

class VoluntaryPrayerFailed extends VoluntaryPrayerState {
  final Failure failure;

  const VoluntaryPrayerFailed(this.failure);

  @override
  List<Object> get props => [failure];
}
