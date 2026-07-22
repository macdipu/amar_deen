import 'package:injectable/injectable.dart';

import '../repositories/permission_repository.dart';

/// Requests notification permission.
@injectable
class RequestNotificationPermission {
  final PermissionRepository repository;

  const RequestNotificationPermission(this.repository);

  Future<void> call() => repository.requestNotificationPermission();
}
