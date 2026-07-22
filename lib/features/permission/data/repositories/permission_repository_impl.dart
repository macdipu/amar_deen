import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/repositories/permission_repository.dart';
import '../datasources/permission_local_data_source.dart';

@LazySingleton(as: PermissionRepository)
class PermissionRepositoryImpl implements PermissionRepository {
  final PermissionLocalDataSource localDataSource;

  const PermissionRepositoryImpl(this.localDataSource);

  @override
  Future<bool> requestLocationPermission() async {
    final status = await localDataSource.requestLocationPermission();
    return status.isGranted;
  }

  @override
  Future<void> requestNotificationPermission() =>
      localDataSource.requestNotificationPermission();

  @override
  Future<void> requestExactAlarmPermission() =>
      localDataSource.requestExactAlarmPermission();
}
