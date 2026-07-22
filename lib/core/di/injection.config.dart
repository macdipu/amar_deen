// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:amar_deen/features/allah_name/data/datasources/allah_name_local_data_source.dart'
    as _i221;
import 'package:amar_deen/features/allah_name/data/repositories/allah_name_repository_impl.dart'
    as _i766;
import 'package:amar_deen/features/allah_name/domain/repositories/allah_name_repository.dart'
    as _i858;
import 'package:amar_deen/features/allah_name/domain/usecases/get_allah_names.dart'
    as _i316;
import 'package:amar_deen/features/dua_azkar/data/azkar/datasources/azkar_favorites_local_data_source.dart'
    as _i650;
import 'package:amar_deen/features/dua_azkar/data/azkar/datasources/azkar_local_data_source.dart'
    as _i481;
import 'package:amar_deen/features/dua_azkar/data/azkar/repositories/azkar_repository_impl.dart'
    as _i920;
import 'package:amar_deen/features/dua_azkar/data/dua/datasources/dua_local_data_source.dart'
    as _i708;
import 'package:amar_deen/features/dua_azkar/data/dua/repositories/dua_repository_impl.dart'
    as _i659;
import 'package:amar_deen/features/dua_azkar/domain/azkar/repositories/azkar_repository.dart'
    as _i70;
import 'package:amar_deen/features/dua_azkar/domain/azkar/usecases/get_azkar_categories.dart'
    as _i6;
import 'package:amar_deen/features/dua_azkar/domain/azkar/usecases/get_azkar_chapters.dart'
    as _i854;
import 'package:amar_deen/features/dua_azkar/domain/azkar/usecases/get_azkar_favorite_item_ids.dart'
    as _i896;
import 'package:amar_deen/features/dua_azkar/domain/azkar/usecases/get_azkar_favorites.dart'
    as _i651;
import 'package:amar_deen/features/dua_azkar/domain/azkar/usecases/get_azkar_items.dart'
    as _i317;
import 'package:amar_deen/features/dua_azkar/domain/azkar/usecases/toggle_azkar_favorite.dart'
    as _i749;
import 'package:amar_deen/features/dua_azkar/domain/dua/repositories/dua_repository.dart'
    as _i816;
import 'package:amar_deen/features/dua_azkar/domain/dua/usecases/get_duas.dart'
    as _i899;
import 'package:amar_deen/features/dua_azkar/domain/dua/usecases/toggle_dua_favorite.dart'
    as _i553;
import 'package:amar_deen/features/live_tv/data/datasources/live_tv_connectivity_data_source.dart'
    as _i278;
import 'package:amar_deen/features/live_tv/data/datasources/live_tv_remote_data_source.dart'
    as _i460;
import 'package:amar_deen/features/live_tv/data/repositories/live_tv_repository_impl.dart'
    as _i551;
import 'package:amar_deen/features/live_tv/domain/repositories/live_tv_repository.dart'
    as _i445;
import 'package:amar_deen/features/live_tv/domain/usecases/get_live_tv_channels.dart'
    as _i787;
import 'package:amar_deen/features/permission/data/datasources/permission_local_data_source.dart'
    as _i392;
import 'package:amar_deen/features/permission/data/repositories/permission_repository_impl.dart'
    as _i972;
import 'package:amar_deen/features/permission/domain/repositories/permission_repository.dart'
    as _i672;
import 'package:amar_deen/features/permission/domain/usecases/request_exact_alarm_permission.dart'
    as _i859;
import 'package:amar_deen/features/permission/domain/usecases/request_location_permission.dart'
    as _i823;
import 'package:amar_deen/features/permission/domain/usecases/request_notification_permission.dart'
    as _i187;
import 'package:amar_deen/features/prayer_times/data/datasources/adhan_local_data_source.dart'
    as _i436;
import 'package:amar_deen/features/prayer_times/data/repositories/prayer_times_repository_impl.dart'
    as _i903;
import 'package:amar_deen/features/prayer_times/domain/repositories/prayer_times_repository.dart'
    as _i882;
import 'package:amar_deen/features/prayer_times/domain/usecases/get_prayer_times.dart'
    as _i103;
import 'package:amar_deen/features/prayer_times/domain/usecases/get_voluntary_prayer_times.dart'
    as _i925;
import 'package:amar_deen/features/qibla/data/datasources/qiblah_local_data_source.dart'
    as _i899;
import 'package:amar_deen/features/qibla/data/repositories/qibla_repository_impl.dart'
    as _i182;
import 'package:amar_deen/features/qibla/domain/repositories/qibla_repository.dart'
    as _i844;
import 'package:amar_deen/features/qibla/domain/usecases/watch_qiblah_direction.dart'
    as _i783;
import 'package:amar_deen/features/quran/data/repositories/quran_repository_impl.dart'
    as _i1016;
import 'package:amar_deen/features/quran/domain/repositories/quran_repository.dart'
    as _i859;
import 'package:amar_deen/features/quran/domain/usecases/toggle_quran_favorite.dart'
    as _i495;
import 'package:amar_deen/features/ramadan/data/repositories/ramadan_repository_impl.dart'
    as _i670;
import 'package:amar_deen/features/ramadan/data/repositories/voluntary_fasting_repository_impl.dart'
    as _i660;
import 'package:amar_deen/features/ramadan/domain/repositories/ramadan_repository.dart'
    as _i739;
import 'package:amar_deen/features/ramadan/domain/repositories/voluntary_fasting_repository.dart'
    as _i128;
import 'package:amar_deen/features/ramadan/domain/usecases/get_ramadan_times.dart'
    as _i920;
import 'package:amar_deen/features/ramadan/domain/usecases/get_upcoming_voluntary_fasting_days.dart'
    as _i153;
import 'package:amar_deen/features/splash/data/datasources/splash_permission_status_data_source.dart'
    as _i6;
import 'package:amar_deen/features/splash/data/repositories/splash_repository_impl.dart'
    as _i306;
import 'package:amar_deen/features/splash/domain/repositories/splash_repository.dart'
    as _i861;
import 'package:amar_deen/features/splash/domain/usecases/determine_splash_destination.dart'
    as _i301;
import 'package:amar_deen/features/tasbih/data/datasources/tasbih_local_data_source.dart'
    as _i520;
import 'package:amar_deen/features/tasbih/data/repositories/tasbih_repository_impl.dart'
    as _i918;
import 'package:amar_deen/features/tasbih/domain/repositories/tasbih_repository.dart'
    as _i675;
import 'package:amar_deen/features/tasbih/domain/usecases/create_tasbih.dart'
    as _i356;
import 'package:amar_deen/features/tasbih/domain/usecases/delete_tasbih.dart'
    as _i303;
import 'package:amar_deen/features/tasbih/domain/usecases/edit_tasbih.dart'
    as _i115;
import 'package:amar_deen/features/tasbih/domain/usecases/get_tasbihs.dart'
    as _i1040;
import 'package:amar_deen/features/tasbih/domain/usecases/toggle_tasbih_favorite.dart'
    as _i150;
import 'package:amar_deen/features/zakat/domain/usecases/calculate_zakat.dart'
    as _i646;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

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
    gh.factory<_i646.CalculateZakat>(() => const _i646.CalculateZakat());
    gh.lazySingleton<_i460.LiveTvRemoteDataSource>(
        () => const _i460.LiveTvRemoteDataSourceImpl());
    gh.lazySingleton<_i278.LiveTvConnectivityDataSource>(
        () => const _i278.LiveTvConnectivityDataSourceImpl());
    gh.lazySingleton<_i6.SplashPermissionStatusDataSource>(
        () => const _i6.SplashPermissionStatusDataSourceImpl());
    gh.lazySingleton<_i445.LiveTvRepository>(() => _i551.LiveTvRepositoryImpl(
          gh<_i278.LiveTvConnectivityDataSource>(),
          gh<_i460.LiveTvRemoteDataSource>(),
        ));
    gh.lazySingleton<_i520.TasbihLocalDataSource>(
        () => const _i520.TasbihLocalDataSourceImpl());
    gh.lazySingleton<_i128.VoluntaryFastingRepository>(
        () => const _i660.VoluntaryFastingRepositoryImpl());
    gh.lazySingleton<_i859.QuranRepository>(
        () => const _i1016.QuranRepositoryImpl());
    gh.lazySingleton<_i436.AdhanLocalDataSource>(
        () => const _i436.AdhanLocalDataSourceImpl());
    gh.lazySingleton<_i882.PrayerTimesRepository>(() =>
        _i903.PrayerTimesRepositoryImpl(gh<_i436.AdhanLocalDataSource>()));
    gh.lazySingleton<_i481.AzkarLocalDataSource>(
        () => _i481.AzkarLocalDataSourceImpl());
    gh.lazySingleton<_i708.DuaLocalDataSource>(
        () => const _i708.DuaLocalDataSourceImpl());
    gh.lazySingleton<_i816.DuaRepository>(
        () => _i659.DuaRepositoryImpl(gh<_i708.DuaLocalDataSource>()));
    gh.lazySingleton<_i899.QiblaLocalDataSource>(
        () => const _i899.QiblaLocalDataSourceImpl());
    gh.factory<_i103.GetPrayerTimes>(
        () => _i103.GetPrayerTimes(gh<_i882.PrayerTimesRepository>()));
    gh.factory<_i925.GetVoluntaryPrayerTimes>(
        () => _i925.GetVoluntaryPrayerTimes(gh<_i882.PrayerTimesRepository>()));
    gh.lazySingleton<_i221.AllahNameLocalDataSource>(
        () => const _i221.AllahNameLocalDataSourceImpl());
    gh.lazySingleton<_i650.AzkarFavoritesLocalDataSource>(
        () => const _i650.AzkarFavoritesLocalDataSourceImpl());
    gh.lazySingleton<_i392.PermissionLocalDataSource>(
        () => const _i392.PermissionLocalDataSourceImpl());
    gh.factory<_i495.ToggleQuranFavorite>(
        () => _i495.ToggleQuranFavorite(gh<_i859.QuranRepository>()));
    gh.factory<_i899.GetDuas>(() => _i899.GetDuas(gh<_i816.DuaRepository>()));
    gh.factory<_i553.ToggleDuaFavorite>(
        () => _i553.ToggleDuaFavorite(gh<_i816.DuaRepository>()));
    gh.factory<_i153.GetUpcomingVoluntaryFastingDays>(() =>
        _i153.GetUpcomingVoluntaryFastingDays(
            gh<_i128.VoluntaryFastingRepository>()));
    gh.lazySingleton<_i739.RamadanRepository>(
        () => _i670.RamadanRepositoryImpl(gh<_i882.PrayerTimesRepository>()));
    gh.factory<_i787.GetLiveTvChannels>(
        () => _i787.GetLiveTvChannels(gh<_i445.LiveTvRepository>()));
    gh.lazySingleton<_i861.SplashRepository>(() =>
        _i306.SplashRepositoryImpl(gh<_i6.SplashPermissionStatusDataSource>()));
    gh.lazySingleton<_i675.TasbihRepository>(
        () => _i918.TasbihRepositoryImpl(gh<_i520.TasbihLocalDataSource>()));
    gh.lazySingleton<_i70.AzkarRepository>(() => _i920.AzkarRepositoryImpl(
          gh<_i481.AzkarLocalDataSource>(),
          gh<_i650.AzkarFavoritesLocalDataSource>(),
        ));
    gh.lazySingleton<_i844.QiblaRepository>(
        () => _i182.QiblaRepositoryImpl(gh<_i899.QiblaLocalDataSource>()));
    gh.lazySingleton<_i672.PermissionRepository>(() =>
        _i972.PermissionRepositoryImpl(gh<_i392.PermissionLocalDataSource>()));
    gh.factory<_i920.GetRamadanTimes>(
        () => _i920.GetRamadanTimes(gh<_i739.RamadanRepository>()));
    gh.lazySingleton<_i858.AllahNameRepository>(() =>
        _i766.AllahNameRepositoryImpl(gh<_i221.AllahNameLocalDataSource>()));
    gh.factory<_i316.GetAllahNames>(
        () => _i316.GetAllahNames(gh<_i858.AllahNameRepository>()));
    gh.factory<_i356.CreateTasbih>(
        () => _i356.CreateTasbih(gh<_i675.TasbihRepository>()));
    gh.factory<_i303.DeleteTasbih>(
        () => _i303.DeleteTasbih(gh<_i675.TasbihRepository>()));
    gh.factory<_i115.EditTasbih>(
        () => _i115.EditTasbih(gh<_i675.TasbihRepository>()));
    gh.factory<_i1040.GetTasbihs>(
        () => _i1040.GetTasbihs(gh<_i675.TasbihRepository>()));
    gh.factory<_i150.ToggleTasbihFavorite>(
        () => _i150.ToggleTasbihFavorite(gh<_i675.TasbihRepository>()));
    gh.factory<_i6.GetAzkarCategories>(
        () => _i6.GetAzkarCategories(gh<_i70.AzkarRepository>()));
    gh.factory<_i854.GetAzkarChapters>(
        () => _i854.GetAzkarChapters(gh<_i70.AzkarRepository>()));
    gh.factory<_i896.GetAzkarFavoriteItemIds>(
        () => _i896.GetAzkarFavoriteItemIds(gh<_i70.AzkarRepository>()));
    gh.factory<_i651.GetAzkarFavorites>(
        () => _i651.GetAzkarFavorites(gh<_i70.AzkarRepository>()));
    gh.factory<_i317.GetAzkarItems>(
        () => _i317.GetAzkarItems(gh<_i70.AzkarRepository>()));
    gh.factory<_i749.ToggleAzkarFavorite>(
        () => _i749.ToggleAzkarFavorite(gh<_i70.AzkarRepository>()));
    gh.factory<_i783.WatchQiblahDirection>(
        () => _i783.WatchQiblahDirection(gh<_i844.QiblaRepository>()));
    gh.factory<_i301.DetermineSplashDestination>(
        () => _i301.DetermineSplashDestination(gh<_i861.SplashRepository>()));
    gh.factory<_i859.RequestExactAlarmPermission>(() =>
        _i859.RequestExactAlarmPermission(gh<_i672.PermissionRepository>()));
    gh.factory<_i823.RequestLocationPermission>(() =>
        _i823.RequestLocationPermission(gh<_i672.PermissionRepository>()));
    gh.factory<_i187.RequestNotificationPermission>(() =>
        _i187.RequestNotificationPermission(gh<_i672.PermissionRepository>()));
    return this;
  }
}
