import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/prayer_times/presentation/screen/voluntary_prayer_screen.dart';
import '../../features/qibla/presentation/screen/qibla_screen.dart';
import '../../features/ramadan/presentation/screen/ramadan_screen.dart';
import '../../features/zakat/presentation/screen/zakat_calculator_screen.dart';
import '../error/exceptions.dart';
import '../../features/allah_name/presentation/screen/allah_name_screen.dart';
import '../../features/dua_azkar/presentation/azkar/screen/azkar_screen.dart';
import '../../features/bottom_tab/presentation/screen/tab_screen.dart';
import '../../features/dua_azkar/presentation/dua/screen/dua_screen.dart';
import '../../features/error/presentation/screen/database_error_screen.dart';
import '../../features/live_tv/presentation/screen/live_tv_screen.dart';
import '../../features/permission/presentation/screen/location_permission_screen.dart';
import '../../features/permission/presentation/screen/notification_permission_screen.dart';
import '../../features/prayer_times/presentation/screen/prayer_time_settings_screen.dart';
import '../../features/prayer_times/presentation/screen/prayer_timing_screen.dart';
import '../../features/quran/presentation/screen/option_screen.dart';
import '../../features/quran/presentation/screen/quran_screen.dart';
import '../../features/settings/presentation/screen/thankyou_screen.dart';
import '../../features/splash/presentation/screen/splash_screen.dart';
import '../../features/tasbih/presentation/screen/tasbih_screen.dart';

/// Route path constants, carried over unchanged from the old
/// `RouteGenerator` so existing call sites only need a navigation-API swap
/// (`Navigator.of(context).pushNamed(X)` -> `context.push(X)`), not new values.
abstract class AppRoutes {
  static const String splash = '/';
  static const String tabScreen = '/tab';
  static const String prayerTimingPage = '/prayer_timing';
  static const String prayerTimeSettings = '/prayer_time_settings';
  static const String voluntaryPrayers = '/voluntary_prayers';
  static const String ramadan = '/ramadan';
  static const String zakatCalculator = '/zakat_calculator';
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
      path: AppRoutes.ramadan,
      builder: (context, state) => const RamadanScreen(),
    ),
    GoRoute(
      path: AppRoutes.zakatCalculator,
      builder: (context, state) => const ZakatCalculatorScreen(),
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
