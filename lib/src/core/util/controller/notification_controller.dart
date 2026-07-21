import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sirat_e_mustaqeem/l10n/generated/app_localizations.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/notifications/azan_scheduler_service.dart';
import '../../../../core/notifications/voluntary_fasting_reminder_service.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../features/prayer_times/domain/usecases/get_prayer_times.dart';
import '../../../../features/prayer_times/presentation/bloc/azan_settings_bloc/azan_settings_bloc.dart';
import '../../../../features/ramadan/domain/entities/voluntary_fasting_day.dart';
import '../../../../features/ramadan/domain/usecases/get_upcoming_voluntary_fasting_days.dart';
import '../../notification/notification_service.dart';
import '../../notification/receive_notification.dart';
import '../bloc/daily_reminder/daily_reminder_bloc.dart';
import '../bloc/location/location_bloc.dart';
import '../bloc/prayer_time_config/prayer_time_config_bloc.dart';
import '../bloc/prayer_timing_bloc/timing_bloc.dart';
import '../prayer_name.dart';
import '../voluntary_fasting_label.dart';

/// Notification id owned by the daily reminder feature - distinct from
/// `AzanSchedulerService.ownedNotificationIds` (0-9) and
/// `VoluntaryFastingReminderService.ownedNotificationIds` (20-23), so
/// [NotificationService.cancelAllNotifications] / [cancelNotifications]
/// calls from either of those schedulers never touch this one.
const int kDailyReminderNotificationId = 40;

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

  final l10n = AppLocalizations.of(context);
  final notificationText = {
    for (final key in kAzanPrayerNames)
      key: (
        title: l10n.azanNotificationTitle(localizedPrayerName(context, key)),
        body: l10n.azanNotificationBody(localizedPrayerName(context, key)),
      ),
  };

  await AzanSchedulerService().scheduleAzans(
    today: timingState.prayerTimes,
    tomorrow: tomorrow,
    enabledByPrayer: enabledByPrayer,
    notificationText: notificationText,
  );
}

/// Recomputes and reschedules voluntary-fasting-day reminder notifications
/// (next Monday, next Thursday, next Ayyam al-Beed, next Arafah). Call
/// alongside [rescheduleAzans] at the same trigger points (app open,
/// master notification switch turned back on) - unlike Azan, this doesn't
/// depend on location/prayer-time config at all (purely Hijri-calendar
/// date math), so it has no early-return gate beyond the caller already
/// having checked the master notification permission.
Future<void> rescheduleVoluntaryFastingReminders(BuildContext context) async {
  final l10n = AppLocalizations.of(context);
  final upcomingFastingDays = getIt<GetUpcomingVoluntaryFastingDays>()();

  final notificationText = {
    for (final type in VoluntaryFastingType.values)
      type: (
        title: l10n.voluntaryFastingReminderTitle(
          voluntaryFastingTypeLabel(context, type),
        ),
        body: l10n.voluntaryFastingReminderBody,
      ),
  };

  await VoluntaryFastingReminderService().scheduleReminders(
    upcomingFastingDays: upcomingFastingDays,
    notificationText: notificationText,
  );
}

/// Schedules or cancels the daily reminder notification depending on
/// [DailyReminderBloc]'s current state. Unlike [rescheduleAzans] and
/// [rescheduleVoluntaryFastingReminders], this doesn't need to be re-run
/// on every app open - `showDailyRepeatingNotification` uses
/// `matchDateTimeComponents: DateTimeComponents.time`, so the OS itself
/// re-fires it daily. Call this only when the user toggles the reminder
/// or changes its time, or when the master notification switch is turned
/// back on.
Future<void> rescheduleDailyReminder(BuildContext context) async {
  final reminderState = BlocProvider.of<DailyReminderBloc>(context).state;

  await NotificationService()
      .cancelNotifications([kDailyReminderNotificationId]);

  if (!reminderState.enabled) {
    return;
  }

  final l10n = AppLocalizations.of(context);
  await NotificationService().showDailyRepeatingNotification(
    id: kDailyReminderNotificationId,
    title: l10n.dailyReminderNotificationTitle,
    body: l10n.dailyReminderNotificationBody,
    hour: reminderState.hour,
    minute: reminderState.minute,
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
