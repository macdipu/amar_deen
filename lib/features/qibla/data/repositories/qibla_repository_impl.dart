import 'package:injectable/injectable.dart';

import '../../domain/entities/qiblah_direction_entity.dart';
import '../../domain/repositories/qibla_repository.dart';
import '../datasources/qiblah_local_data_source.dart';

@LazySingleton(as: QiblaRepository)
class QiblaRepositoryImpl implements QiblaRepository {
  final QiblaLocalDataSource localDataSource;

  const QiblaRepositoryImpl(this.localDataSource);

  @override
  Stream<QiblahDirectionEntity> watchQiblahDirection() {
    return localDataSource.watchQiblahDirection().map(
          (direction) => QiblahDirectionEntity(
            qiblahBearing: direction.qiblah,
            heading: direction.direction,
          ),
        );
  }
}
