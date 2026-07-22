import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/entities/splash_destination.dart';
import '../../domain/repositories/splash_repository.dart';
import '../datasources/splash_permission_status_data_source.dart';

@LazySingleton(as: SplashRepository)
class SplashRepositoryImpl implements SplashRepository {
  final SplashPermissionStatusDataSource dataSource;

  const SplashRepositoryImpl(this.dataSource);

  @override
  Future<SplashDestination> determineDestination() async {
    final locationGranted = (await dataSource.locationStatus()).isGranted;
    if (!locationGranted) return SplashDestination.locationPermission;

    final notificationGranted =
        (await dataSource.notificationStatus()).isGranted;
    if (!notificationGranted) return SplashDestination.notificationPermission;

    return SplashDestination.tabScreen;
  }
}
