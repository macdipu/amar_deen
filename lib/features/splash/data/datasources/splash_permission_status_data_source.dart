import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

/// Wraps the `permission_handler` status checks the splash screen uses to
/// decide where to route the user next.
abstract class SplashPermissionStatusDataSource {
  Future<PermissionStatus> locationStatus();
  Future<PermissionStatus> notificationStatus();
}

@LazySingleton(as: SplashPermissionStatusDataSource)
class SplashPermissionStatusDataSourceImpl
    implements SplashPermissionStatusDataSource {
  const SplashPermissionStatusDataSourceImpl();

  @override
  Future<PermissionStatus> locationStatus() => Permission.location.status;

  @override
  Future<PermissionStatus> notificationStatus() =>
      Permission.notification.status;
}
