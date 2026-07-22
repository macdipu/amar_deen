import '../../features/prayer_times/domain/entities/prayer_times_entity.dart';
import 'notification_service.dart';

/// Schedules exact, one-shot Azan notifications for today's remaining
/// prayers and all of tomorrow's, respecting a per-prayer enable/disable
/// map.
///
/// There's no background task/WorkManager integration in this app, so a
/// schedule is only ever as fresh as the last time this was called - call
/// it again whenever prayer times are (re)loaded (app open, settings
/// change) to keep it accurate. Without the app being reopened, scheduled
/// notifications won't reach further than "today + tomorrow".
class AzanSchedulerService {
  static const Map<String, int> _baseNotificationId = {
    'Fajr': 0,
    'Dhuhr': 1,
    'Asr': 2,
    'Maghrib': 3,
    'Isha': 4,
  };

  /// This service's own notification IDs (today's ids 0-4 + tomorrow's
  /// ids 5-9, per [_baseNotificationId]/`idOffset`). Cancelling exactly
  /// this range - not [NotificationService.cancelAllNotifications] - is
  /// what lets other schedulers (e.g. voluntary-fasting reminders) keep
  /// their own pending notifications across an Azan reschedule, which
  /// happens far more often (essentially every app open) than a user
  /// explicitly turning notifications off.
  static const List<int> ownedNotificationIds = [
    0, 1, 2, 3, 4, // today
    5, 6, 7, 8, 9, // tomorrow
  ];

  Future<void> scheduleAzans({
    required PrayerTimesEntity today,
    required PrayerTimesEntity tomorrow,
    required Map<String, bool> enabledByPrayer,
    required Map<String, ({String title, String body})> notificationText,
  }) async {
    await NotificationService().cancelNotifications(ownedNotificationIds);

    final now = DateTime.now();
    await _scheduleDay(today, enabledByPrayer, notificationText, now,
        idOffset: 0);
    await _scheduleDay(tomorrow, enabledByPrayer, notificationText, now,
        idOffset: 5);
  }

  Future<void> _scheduleDay(
    PrayerTimesEntity prayerTimes,
    Map<String, bool> enabledByPrayer,
    Map<String, ({String title, String body})> notificationText,
    DateTime now, {
    required int idOffset,
  }) async {
    final entries = <String, DateTime>{
      'Fajr': prayerTimes.fajr,
      'Dhuhr': prayerTimes.dhuhr,
      'Asr': prayerTimes.asr,
      'Maghrib': prayerTimes.maghrib,
      'Isha': prayerTimes.isha,
    };

    for (final entry in entries.entries) {
      if (enabledByPrayer[entry.key] == false) continue;
      if (!entry.value.isAfter(now)) continue;

      final text = notificationText[entry.key]!;
      await NotificationService().showPrayerNotification(
        id: _baseNotificationId[entry.key]! + idOffset,
        title: text.title,
        body: text.body,
        duration: entry.value.difference(now),
      );
    }
  }
}
