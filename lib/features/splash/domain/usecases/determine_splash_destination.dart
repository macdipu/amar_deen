import 'package:injectable/injectable.dart';

import '../entities/splash_destination.dart';
import '../repositories/splash_repository.dart';

/// Decides which screen the app should show right after splash, once the
/// local database has finished loading.
@injectable
class DetermineSplashDestination {
  final SplashRepository repository;

  const DetermineSplashDestination(this.repository);

  Future<SplashDestination> call() => repository.determineDestination();
}
