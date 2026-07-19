import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../notification/notification_service.dart';
import '../../notification/receive_notification.dart';

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
