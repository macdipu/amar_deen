import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

/// Wraps the `connectivity_plus` plugin's device connectivity check.
abstract class LiveTvConnectivityDataSource {
  Future<bool> hasConnection();
}

@LazySingleton(as: LiveTvConnectivityDataSource)
class LiveTvConnectivityDataSourceImpl implements LiveTvConnectivityDataSource {
  const LiveTvConnectivityDataSourceImpl();

  @override
  Future<bool> hasConnection() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
