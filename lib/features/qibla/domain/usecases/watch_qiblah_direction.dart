import '../entities/qiblah_direction_entity.dart';
import '../repositories/qibla_repository.dart';

/// Watches the live Qiblah direction relative to the device's heading.
class WatchQiblahDirection {
  final QiblaRepository repository;

  const WatchQiblahDirection(this.repository);

  Stream<QiblahDirectionEntity> call() => repository.watchQiblahDirection();
}
