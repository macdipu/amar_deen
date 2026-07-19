import 'package:flutter_qiblah/flutter_qiblah.dart';

/// Wraps the `flutter_qiblah` plugin, which fuses device location and
/// magnetometer/accelerometer sensors internally.
abstract class QiblaLocalDataSource {
  Stream<QiblahDirection> watchQiblahDirection();
}

class QiblaLocalDataSourceImpl implements QiblaLocalDataSource {
  const QiblaLocalDataSourceImpl();

  @override
  Stream<QiblahDirection> watchQiblahDirection() => FlutterQiblah.qiblahStream;
}
