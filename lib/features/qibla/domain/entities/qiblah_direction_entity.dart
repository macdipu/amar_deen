import 'package:equatable/equatable.dart';

/// A snapshot of the live Qiblah bearing versus the device's current heading.
class QiblahDirectionEntity extends Equatable {
  /// Bearing from true north to the Qiblah, in degrees (0-360).
  final double qiblahBearing;

  /// Device's current compass heading, in degrees (0-360).
  final double heading;

  const QiblahDirectionEntity({
    required this.qiblahBearing,
    required this.heading,
  });

  @override
  List<Object> get props => [qiblahBearing, heading];
}
