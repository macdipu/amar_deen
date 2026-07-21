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
import 'package:sirat_e_mustaqeem/features/quran/data/repositories/quran_repository_impl.dart'
    as _i607;
import 'package:sirat_e_mustaqeem/features/quran/domain/repositories/quran_repository.dart'
    as _i608;
import 'package:sirat_e_mustaqeem/features/quran/domain/usecases/toggle_quran_favorite.dart'
    as _i609;
import 'package:sirat_e_mustaqeem/features/ramadan/data/repositories/ramadan_repository_impl.dart'
    as _i601;
import 'package:sirat_e_mustaqeem/features/ramadan/data/repositories/voluntary_fasting_repository_impl.dart'
    as _i604;
import 'package:sirat_e_mustaqeem/features/ramadan/domain/repositories/ramadan_repository.dart'
    as _i602;
import 'package:sirat_e_mustaqeem/features/ramadan/domain/repositories/voluntary_fasting_repository.dart'
    as _i605;
import 'package:sirat_e_mustaqeem/features/ramadan/domain/usecases/get_ramadan_times.dart'
    as _i603;
import 'package:sirat_e_mustaqeem/features/ramadan/domain/usecases/get_upcoming_voluntary_fasting_days.dart'
    as _i606;
import 'package:sirat_e_mustaqeem/features/zakat/domain/usecases/calculate_zakat.dart'
    as _i610;

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
    gh.lazySingleton<_i608.QuranRepository>(
        () => const _i607.QuranRepositoryImpl());
    gh.lazySingleton<_i602.RamadanRepository>(
        () => _i601.RamadanRepositoryImpl(gh<_i373.PrayerTimesRepository>()));
    gh.lazySingleton<_i605.VoluntaryFastingRepository>(
        () => const _i604.VoluntaryFastingRepositoryImpl());
    gh.factory<_i955.WatchQiblahDirection>(
        () => _i955.WatchQiblahDirection(gh<_i677.QiblaRepository>()));
    gh.factory<_i609.ToggleQuranFavorite>(
        () => _i609.ToggleQuranFavorite(gh<_i608.QuranRepository>()));
    gh.factory<_i603.GetRamadanTimes>(
        () => _i603.GetRamadanTimes(gh<_i602.RamadanRepository>()));
    gh.factory<_i606.GetUpcomingVoluntaryFastingDays>(() =>
        _i606.GetUpcomingVoluntaryFastingDays(
            gh<_i605.VoluntaryFastingRepository>()));
    gh.factory<_i610.CalculateZakat>(() => const _i610.CalculateZakat());
    return this;
  }
}
