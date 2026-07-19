part of 'timing_bloc.dart';

abstract class TimingState extends Equatable {
  const TimingState();
}

class TimingInitial extends TimingState {
  @override
  List<Object> get props => [];
}

class TimingLoading extends TimingState {
  @override
  List<Object> get props => [];
}

class TimingLoaded extends TimingState {
  final PrayerTimesEntity prayerTimes;
  TimingLoaded(this.prayerTimes);
  @override
  List<Object> get props => [prayerTimes];
}

class TimingFailed extends TimingState {
  final Failure failure;

  TimingFailed(this.failure);
  @override
  List<Object> get props => [failure];
}
