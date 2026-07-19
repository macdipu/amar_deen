import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/notifications/azan_scheduler_service.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../features/prayer_times/domain/usecases/get_prayer_times.dart';
import '../../../../features/prayer_times/presentation/bloc/azan_settings_bloc/azan_settings_bloc.dart';
import '../../notification/notification_service.dart';
import '../../notification/receive_notification.dart';
import '../bloc/location/location_bloc.dart';
import '../bloc/prayer_time_config/prayer_time_config_bloc.dart';
import '../bloc/prayer_timing_bloc/timing_bloc.dart';

/// Recomputes tomorrow's prayer times and reschedules Azan notifications
/// for today's remaining prayers plus all of tomorrow's, respecting the
/// per-prayer toggle in [AzanSettingsBloc]. Call whenever prayer times
/// change (fresh load, settings change) or the master notification switch
/// is turned back on - see `AzanSchedulerService` for why this needs to
/// be re-run rather than scheduled once.
Future<void> rescheduleAzans(BuildContext context) async {
  final timingState = BlocProvider.of<TimingBloc>(context).state;
  final locationState = BlocProvider.of<LocationBloc>(context).state;
  if (timingState is! TimingLoaded || locationState is! LocationSuccess) {
    return;
  }

  final prayerConfig = BlocProvider.of<PrayerTimeConfigBloc>(context).state;
  final enabledByPrayer =
      BlocProvider.of<AzanSettingsBloc>(context).state.enabledByPrayer;

  final tomorrowBaseDate = DateTime.now().add(
    Duration(days: prayerConfig.dayOffset + 1),
  );
  final tomorrow = getIt<GetPrayerTimes>()(
    latitude: locationState.latitude,
    longitude: locationState.longitude,
    date: DateTime(
      tomorrowBaseDate.year,
      tomorrowBaseDate.month,
      tomorrowBaseDate.day,
    ),
    method: prayerConfig.method,
    madhab: prayerConfig.madhab,
  );

  await AzanSchedulerService().scheduleAzans(
    today: timingState.prayerTimes,
    tomorrow: tomorrow,
    enabledByPrayer: enabledByPrayer,
  );
}

void configureDidReceiveLocalNotificationSubject(BuildContext context) {
  NotificationService()
      .didReceiveLocalNotificationSubject
      .stream
      .listen((ReceivedNotification receivedNotification) async {
    await context.push(AppRoutes.prayerTimingPage);
  });
}

void configureSelectNotificationSubject(BuildContext context) {
  NotificationService()
      .selectNotificationSubject
      .stream
      .listen((String? payload) async {
    await context.push(AppRoutes.prayerTimingPage);
  });
}
