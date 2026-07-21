part of 'ramadan_bloc.dart';

abstract class RamadanState extends Equatable {
  const RamadanState();
}

class RamadanInitial extends RamadanState {
  @override
  List<Object> get props => [];
}

class RamadanLoading extends RamadanState {
  @override
  List<Object> get props => [];
}

class RamadanLoaded extends RamadanState {
  final RamadanTimesEntity ramadanTimes;

  const RamadanLoaded(this.ramadanTimes);

  @override
  List<Object> get props => [ramadanTimes];
}

class RamadanFailed extends RamadanState {
  final Failure failure;

  const RamadanFailed(this.failure);

  @override
  List<Object> get props => [failure];
}
