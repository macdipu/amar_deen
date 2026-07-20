import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/prayer_times/presentation/screen/voluntary_prayer_screen.dart';
import '../../features/qibla/presentation/screen/qibla_screen.dart';
import '../../src/core/error/exceptions.dart';
import '../../src/features/allah_name/screen/allah_name_screen.dart';
import '../../src/features/azkar/screen/azkar_screen.dart';
import '../../src/features/bottom_tab/screen/tab_screen.dart';
import '../../src/features/dua/screen/dua_screen.dart';
import '../../src/features/error/screen/database_error_screen.dart';
import '../../src/features/live_tv/screen/live_tv_screen.dart';
import '../../src/features/permission/screen/location_permission_screen.dart';
import '../../src/features/permission/screen/notification_permission_screen.dart';
import '../../src/features/prayer_timing/screen/prayer_time_settings_screen.dart';
import '../../src/features/prayer_timing/screen/prayer_timing_screen.dart';
import '../../src/features/quran/screen/option_screen.dart';
import '../../src/features/quran/screen/quran_screen.dart';
import '../../src/features/setting/screen/thankyou_screen.dart';
import '../../src/features/splash/screen/splash_screen.dart';
import '../../src/features/tasbih/screen/tasbih_screen.dart';

/// Route path constants, carried over unchanged from the old
/// `RouteGenerator` so existing call sites only need a navigation-API swap
/// (`Navigator.of(context).pushNamed(X)` -> `context.push(X)`), not new values.
abstract class AppRoutes {
  static const String splash = '/';
  static const String tabScreen = '/tab';
  static const String prayerTimingPage = '/prayer_timing';
  static const String prayerTimeSettings = '/prayer_time_settings';
  static const String voluntaryPrayers = '/voluntary_prayers';
  static const String qibla = '/qibla';
  static const String thankyou = '/thank_you';
  static const String databaseError = '/database_error';
  static const String allahName = '/allah_name';
  static const String tasbih = '/tasbih';
  static const String dua = '/dua';
  static const String quran = '/quran';
  static const String quranSettings = '/quran_settings';
  static const String liveTv = '/live_tv';
  static const String azkar = '/azkar';
  static const String locationPermission = '/location_permission';
  static const String notificationPermission = '/notification_permission';

  AppRoutes._();
}

/// Navigator key for the app's single root [GoRouter], kept as a top-level
/// key (rather than scoped to a widget) since some non-widget callers
/// (e.g. notification handling) may need to navigate without a `BuildContext`.
final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: appNavigatorKey,
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.tabScreen,
      builder: (context, state) => const TabScreen(),
    ),
    GoRoute(
      path: AppRoutes.prayerTimingPage,
      builder: (context, state) => const PrayerTimingScreen(),
    ),
    GoRoute(
      path: AppRoutes.prayerTimeSettings,
      builder: (context, state) => const PrayerTimeSettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.voluntaryPrayers,
      builder: (context, state) => const VoluntaryPrayerScreen(),
    ),
    GoRoute(
      path: AppRoutes.qibla,
      builder: (context, state) => const QiblaScreen(),
    ),
    GoRoute(
      path: AppRoutes.thankyou,
      builder: (context, state) => const ThankyouScreen(),
    ),
    GoRoute(
      path: AppRoutes.databaseError,
      builder: (context, state) => const DatabaseErrorScreen(),
    ),
    GoRoute(
      path: AppRoutes.allahName,
      builder: (context, state) => const AllahNameScreen(),
    ),
    GoRoute(
      path: AppRoutes.tasbih,
      builder: (context, state) => const TasbihScreen(),
    ),
    GoRoute(
      path: AppRoutes.dua,
      builder: (context, state) => const DuaScreen(),
    ),
    GoRoute(
      path: AppRoutes.quran,
      builder: (context, state) => const QuranScreen(),
    ),
    GoRoute(
      path: AppRoutes.quranSettings,
      builder: (context, state) => const OptionScreen(),
    ),
    GoRoute(
      path: AppRoutes.liveTv,
      builder: (context, state) => const LiveTvScreen(),
    ),
    GoRoute(
      path: AppRoutes.azkar,
      builder: (context, state) => const AzkarScreen(),
    ),
    GoRoute(
      path: AppRoutes.locationPermission,
      builder: (context, state) => const LocationPermissionScreen(),
    ),
    GoRoute(
      path: AppRoutes.notificationPermission,
      builder: (context, state) => const NotificationPermissionScreen(),
    ),
  ],
  errorBuilder: (context, state) => throw RouteException('Route not found'),
);
