/// Requests the OS permissions the app needs during onboarding.
abstract class PermissionRepository {
  /// Requests location access, returning whether it was granted.
  Future<bool> requestLocationPermission();

  /// Requests notification access.
  Future<void> requestNotificationPermission();

  /// Requests Android 12+'s exact-alarm scheduling permission.
  Future<void> requestExactAlarmPermission();
}
