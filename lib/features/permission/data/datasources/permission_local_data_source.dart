import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

/// Wraps the `permission_handler` package calls used during onboarding.
abstract class PermissionLocalDataSource {
  Future<PermissionStatus> requestLocationPermission();
  Future<PermissionStatus> requestNotificationPermission();
  Future<PermissionStatus> requestExactAlarmPermission();
}

@LazySingleton(as: PermissionLocalDataSource)
class PermissionLocalDataSourceImpl implements PermissionLocalDataSource {
  const PermissionLocalDataSourceImpl();

  @override
  Future<PermissionStatus> requestLocationPermission() =>
      Permission.location.request();

  @override
  Future<PermissionStatus> requestNotificationPermission() =>
      Permission.notification.request();

  @override
  Future<PermissionStatus> requestExactAlarmPermission() =>
      // Android 12+'s "Alarms & reminders" permission - lets Azan
      // notifications fire at the exact prayer time rather than being
      // delayed by the system.
      Permission.scheduleExactAlarm.request();
}
