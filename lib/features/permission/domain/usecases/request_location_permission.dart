import 'package:injectable/injectable.dart';

import '../repositories/permission_repository.dart';

/// Requests location permission, returning whether it was granted.
@injectable
class RequestLocationPermission {
  final PermissionRepository repository;

  const RequestLocationPermission(this.repository);

  Future<bool> call() => repository.requestLocationPermission();
}
