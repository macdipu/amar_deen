// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:sirat_e_mustaqeem/features/prayer_times/data/datasources/adhan_local_data_source.dart'
    as _i571;
import 'package:sirat_e_mustaqeem/features/prayer_times/data/repositories/prayer_times_repository_impl.dart'
    as _i867;
import 'package:sirat_e_mustaqeem/features/prayer_times/domain/repositories/prayer_times_repository.dart'
    as _i373;
import 'package:sirat_e_mustaqeem/features/prayer_times/domain/usecases/get_prayer_times.dart'
    as _i1054;
import 'package:sirat_e_mustaqeem/features/prayer_times/domain/usecases/get_voluntary_prayer_times.dart'
    as _i298;
import 'package:sirat_e_mustaqeem/features/qibla/data/datasources/qiblah_local_data_source.dart'
    as _i259;
import 'package:sirat_e_mustaqeem/features/qibla/data/repositories/qibla_repository_impl.dart'
    as _i154;
import 'package:sirat_e_mustaqeem/features/qibla/domain/repositories/qibla_repository.dart'
    as _i677;
import 'package:sirat_e_mustaqeem/features/qibla/domain/usecases/watch_qiblah_direction.dart'
    as _i955;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i571.AdhanLocalDataSource>(
        () => const _i571.AdhanLocalDataSourceImpl());
    gh.lazySingleton<_i373.PrayerTimesRepository>(() =>
        _i867.PrayerTimesRepositoryImpl(gh<_i571.AdhanLocalDataSource>()));
    gh.lazySingleton<_i259.QiblaLocalDataSource>(
        () => const _i259.QiblaLocalDataSourceImpl());
    gh.factory<_i1054.GetPrayerTimes>(
        () => _i1054.GetPrayerTimes(gh<_i373.PrayerTimesRepository>()));
    gh.factory<_i298.GetVoluntaryPrayerTimes>(
        () => _i298.GetVoluntaryPrayerTimes(gh<_i373.PrayerTimesRepository>()));
    gh.lazySingleton<_i677.QiblaRepository>(
        () => _i154.QiblaRepositoryImpl(gh<_i259.QiblaLocalDataSource>()));
    gh.factory<_i955.WatchQiblahDirection>(
        () => _i955.WatchQiblahDirection(gh<_i677.QiblaRepository>()));
    return this;
  }
}
