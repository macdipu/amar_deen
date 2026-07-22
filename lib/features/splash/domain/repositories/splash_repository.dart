import '../entities/splash_destination.dart';

/// Decides which screen the app should show right after splash.
abstract class SplashRepository {
  /// Inspects the location/notification permission statuses and returns
  /// the next screen the user should land on.
  Future<SplashDestination> determineDestination();
}
