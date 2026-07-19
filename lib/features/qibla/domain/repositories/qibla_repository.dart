import '../entities/qiblah_direction_entity.dart';

/// Provides a live stream of the Qiblah bearing versus the device's heading.
abstract class QiblaRepository {
  /// Emits on every location/sensor update. Errors on the stream mean
  /// location or sensor data became unavailable.
  Stream<QiblahDirectionEntity> watchQiblahDirection();
}
