import 'package:intl/intl.dart';

import '../../../../features/prayer_times/domain/entities/prayer_times_entity.dart';
import '../../notification/notification_service.dart';

/// Orders a day's [PrayerTimesEntity] into (prayer name, time) pairs and
/// finds which prayer is current/next, for UI highlighting and notification
/// scheduling.
class TimingController {
  final PrayerTimesEntity prayerTimes;

  /// index into [timingsList] of the next/current prayer
  int _timingCount = 0;

  /// whether all of today's prayers have passed, so [timingCount] refers to
  /// tomorrow's Fajr
  bool _forTomorrow = false;

  late final List<MapEntry<String, DateTime>> _timingsList;

  TimingController(this.prayerTimes) {
    _timingsList = [
      MapEntry('Fajr', prayerTimes.fajr),
      MapEntry('Dhuhr', prayerTimes.dhuhr),
      MapEntry('Asr', prayerTimes.asr),
      MapEntry('Maghrib', prayerTimes.maghrib),
      MapEntry('Isha', prayerTimes.isha),
    ];
    _computeTimingCount();
  }

  void _computeTimingCount() {
    final now = DateTime.now();

    for (final entry in _timingsList) {
      if (!now.isBefore(entry.value)) {
        _timingCount++;
      }
    }

    if (_timingCount == 5) {
      _timingCount = 0;
      _forTomorrow = true;
    }
  }

  int get timingCount => _timingCount;
  bool get forTomorrow => _forTomorrow;
  List<MapEntry<String, DateTime>> get timingsList => _timingsList;
  MapEntry<String, DateTime> get currentTiming => _timingsList[_timingCount];
  String get prayer => _timingsList[_timingCount].key;
  DateTime get time => _timingsList[_timingCount].value;
}

String convertTimeTo12HourFormat(DateTime time) =>
    DateFormat('h:mm a').format(time);

Future<List<Map<String, Object>>> loadLocalNotification(
  List<MapEntry<String, DateTime>> timingsList,
) async {
  final now = DateTime.now();
  final List<Map<String, Object>> notificationList = [];

  for (var i = 0; i < timingsList.length; i++) {
    var target = timingsList[i].value;
    if (!target.isAfter(now)) {
      target = target.add(const Duration(days: 1));
    }

    notificationList.add({
      'id': i,
      'title': timingsList[i].key,
      'body': 'The next prayer time is now.',
      'duration': target.difference(now),
    });
  }

  return notificationList;
}

Future<void> addToLocalNotification(
    List<Map<String, Object>> notifications) async {
  await NotificationService().cancelAllNotifications();

  await Future.forEach(notifications, (Map<String, Object> notification) async {
    await NotificationService().showPrayerNotification(
      id: notification['id'] as int,
      title: notification['title'].toString(),
      body: notification['body'].toString(),
      duration: notification['duration'] as Duration,
    );
  });
}
