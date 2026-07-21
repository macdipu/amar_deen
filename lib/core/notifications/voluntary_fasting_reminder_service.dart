import '../../features/ramadan/domain/entities/voluntary_fasting_day.dart';
import '../../src/core/notification/notification_service.dart';

/// Schedules a one-shot reminder notification the evening before each
/// upcoming voluntary fasting day (next Monday, next Thursday, next
/// Ayyam al-Beed, next Arafah) - see `VoluntaryFastingRepositoryImpl` for
/// how each is computed via the Hijri calendar.
///
/// Same standing limitation as `AzanSchedulerService`: no background
/// task/WorkManager integration, so this is only ever as fresh as the
/// last time it ran. Unlike Azan (same-day precision matters), these are
/// day(s)-ahead reminders, so "reschedule on app open" is plenty fresh.
class VoluntaryFastingReminderService {
  static const Map<VoluntaryFastingType, int> _notificationId = {
    VoluntaryFastingType.monday: 20,
    VoluntaryFastingType.thursday: 21,
    VoluntaryFastingType.ayyamAlBeed: 22,
    VoluntaryFastingType.arafah: 23,
  };

  /// This service's own notification IDs - cancelling exactly this range
  /// (not [NotificationService.cancelAllNotifications]) keeps Azan's
  /// pending notifications untouched on reschedule, and vice versa. See
  /// `AzanSchedulerService.ownedNotificationIds`'s doc comment for why
  /// this matters.
  static const List<int> ownedNotificationIds = [20, 21, 22, 23];

  Future<void> scheduleReminders({
    required List<VoluntaryFastingDay> upcomingFastingDays,
    required Map<VoluntaryFastingType, ({String title, String body})>
        notificationText,
  }) async {
    await NotificationService().cancelNotifications(ownedNotificationIds);

    final now = DateTime.now();
    for (final day in upcomingFastingDays) {
      if (!day.reminderAt.isAfter(now)) continue;

      final text = notificationText[day.type]!;
      await NotificationService().showPrayerNotification(
        id: _notificationId[day.type]!,
        title: text.title,
        body: text.body,
        duration: day.reminderAt.difference(now),
      );
    }
  }
}
