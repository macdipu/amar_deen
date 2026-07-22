import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'receive_notification.dart';

/// notification class for handling notification related logics;
///
class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  /// initialize flutter local notification plugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// create stream to add notification class (defined)
  final BehaviorSubject<ReceivedNotification>
      didReceiveLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();

  /// create stream to add notification  (defined) ios<10+
  final BehaviorSubject<String?> selectNotificationSubject =
      BehaviorSubject<String?>();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  /// initialize this notification service
  Future<void> init() async {
    /// use for schedule notification
    await _configureLocalTimeZone();

    /// andriod local notification setting
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    /// ios local notification setting
    /// [onDidRecieveLocalNotification] handler for clicking notification while in
    /// app
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      // onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    /// [onSelectNotification] handler for clicking notification while in
    /// app ios<10+
    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      // onDidReceiveBackgroundNotificationResponse: _onSelectNotification,
    );

    await checkNotification();
  }

  /// add notification to the stream so other page can subscribe it
  /// and get the notification
  // Future _onDidReceiveLocalNotification(
  //   int id,
  //   String? title,
  //   String? body,
  //   String? payload,
  // ) async {
  //   didReceiveLocalNotificationSubject.add(
  //     ReceivedNotification(
  //       id: id,
  //       title: title,
  //       body: body,
  //       payload: payload,
  //     ),
  //   );
  // }

  /// add notification to the stream so other page can subscribe it
  /// and get the notification
  // Future _onSelectNotification(String? payload) async {
  //   selectNotificationSubject.add(payload);
  // }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();

    final String timeZoneName =
        (await FlutterTimezone.getLocalTimezone()).identifier;

    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  /// Cancels only the given notification [ids], leaving any other
  /// scheduler's notifications untouched - unlike [cancelAllNotifications],
  /// which is a genuine "everything, app-wide" wipe (only appropriate for
  /// an explicit "turn off all notifications" action). Schedulers that
  /// reschedule frequently (e.g. on every app open) must use this instead
  /// of [cancelAllNotifications] for their own ID range, or they'll wipe
  /// out every other scheduler's pending notifications too.
  Future<void> cancelNotifications(Iterable<int> ids) async {
    for (final id in ids) {
      await flutterLocalNotificationsPlugin.cancel(id: id);
    }
  }

  /// Schedules a one-shot Azan/prayer-timing notification at [duration]
  /// from now, using an exact alarm that still fires during Doze
  /// (`exactAllowWhileIdle`). Deliberately one-shot, not a daily-repeating
  /// alarm (no `matchDateTimeComponents`) - prayer times shift by roughly a
  /// minute a day, so a fixed daily repeat would slowly drift out of sync.
  /// Callers are expected to reschedule (see `AzanSchedulerService`)
  /// whenever fresh prayer times are loaded.
  ///
  /// NOTE: `slow_spring_board` is the placeholder sound bundled with this
  /// fork (from the flutter_local_notifications example project) - it is
  /// not an actual Azan recording. Swap the raw resource / iOS sound file
  /// for a real Azan audio asset before shipping.
  Future<void> showPrayerNotification(
      {required int id,
      required String title,
      required String body,
      required Duration duration}) async {
    /// android customisation notification
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '1',
      'Prayer Timing',
      // 'Notification to tell user that it is time for Muslim prayer.',
      importance: Importance.max,
      //icon:
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
      // when:
      ticker: 'Prayer Timing',
      visibility: NotificationVisibility.public,
      category: AndroidNotificationCategory.reminder,
    );

    /// ios customisation notification

    DarwinNotificationDetails iosPlatformChannelSpecifics =
        DarwinNotificationDetails(
      sound: 'slow_spring_board.aiff',
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    /// scheduled notification function
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: tz.TZDateTime.now(tz.local).add(duration),
        notificationDetails: platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: '');
  }

  /// Schedules a genuinely OS-level daily-repeating notification at
  /// [hour]:[minute] local time, using `matchDateTimeComponents: time` so
  /// the platform itself re-fires it every day - unlike
  /// [showPrayerNotification], callers do NOT need to reschedule this on
  /// every app open; it only needs to be re-scheduled when the user changes
  /// the reminder time or toggles it on/off (see
  /// `rescheduleDailyReminder`).
  Future<void> showDailyRepeatingNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '2',
      'Daily Reminder',
      importance: Importance.defaultImportance,
      ticker: 'Daily Reminder',
      visibility: NotificationVisibility.public,
      category: AndroidNotificationCategory.reminder,
    );

    DarwinNotificationDetails iosPlatformChannelSpecifics =
        DarwinNotificationDetails();

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        notificationDetails: platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: '');
  }

  Future<void> checkNotification() async {
    final available =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    log(available.length.toString());
  }
}
