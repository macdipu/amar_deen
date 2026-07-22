import 'package:injectable/injectable.dart';

import '../repositories/permission_repository.dart';

/// Requests Android 12+'s exact-alarm scheduling permission.
@injectable
class RequestExactAlarmPermission {
  final PermissionRepository repository;

  const RequestExactAlarmPermission(this.repository);

  Future<void> call() => repository.requestExactAlarmPermission();
}
