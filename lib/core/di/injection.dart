import 'package:get_it/get_it.dart';

import '../../features/qibla/data/datasources/qiblah_local_data_source.dart';
import '../../features/qibla/data/repositories/qibla_repository_impl.dart';
import '../../features/qibla/domain/repositories/qibla_repository.dart';
import '../../features/qibla/domain/usecases/watch_qiblah_direction.dart';

final GetIt getIt = GetIt.instance;

/// Registers app-wide dependencies. Call once from `main()` before `runApp`.
///
/// Hand-written registration for now: this repo's tooling environment has
/// no `flutter`/`dart` binary to run `build_runner`, so the `@LazySingleton`/
/// `@injectable` annotations already on these classes can't be codegen'd
/// into `injection.config.dart` yet. Once build_runner can run
/// (`flutter pub run build_runner build --delete-conflicting-outputs`),
/// add `@InjectableInit()` above this function and replace its body with
/// `getIt.init()`.
void configureDependencies() {
  getIt.registerLazySingleton<QiblaLocalDataSource>(
    () => const QiblaLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<QiblaRepository>(
    () => QiblaRepositoryImpl(getIt()),
  );
  getIt.registerFactory<WatchQiblahDirection>(
    () => WatchQiblahDirection(getIt()),
  );
}
