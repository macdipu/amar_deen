import '../../features/prayer_times/domain/entities/prayer_times_entity.dart';
import '../../src/core/notification/notification_service.dart';

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

  Future<void> scheduleAzans({
    required PrayerTimesEntity today,
    required PrayerTimesEntity tomorrow,
    required Map<String, bool> enabledByPrayer,
  }) async {
    await NotificationService().cancelAllNotifications();

    final now = DateTime.now();
    await _scheduleDay(today, enabledByPrayer, now, idOffset: 0);
    await _scheduleDay(tomorrow, enabledByPrayer, now, idOffset: 5);
  }

  Future<void> _scheduleDay(
    PrayerTimesEntity prayerTimes,
    Map<String, bool> enabledByPrayer,
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

      await NotificationService().showPrayerNotification(
        id: _baseNotificationId[entry.key]! + idOffset,
        title: '${entry.key} Azan',
        body: 'It is time for ${entry.key} prayer.',
        duration: entry.value.difference(now),
      );
    }
  }
}
