part of 'qibla_bloc.dart';

abstract class QiblaState extends Equatable {
  const QiblaState();
}

class QiblaInitial extends QiblaState {
  @override
  List<Object> get props => [];
}

class QiblaLoading extends QiblaState {
  @override
  List<Object> get props => [];
}

class QiblaLoaded extends QiblaState {
  /// Bearing from true north to the Qiblah, in degrees (0-360).
  final double direction;

  /// Device's current compass heading, in degrees (0-360).
  final double heading;

  const QiblaLoaded({required this.direction, required this.heading});

  @override
  List<Object> get props => [direction, heading];
}

class QiblaFailed extends QiblaState {
  final Failure failure;
  const QiblaFailed(this.failure);
  @override
  List<Object> get props => [failure];
}
