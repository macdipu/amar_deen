import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/notification/notification_service.dart';
import '../../../core/util/bloc/notification/notification_bloc.dart';
import '../../../core/util/controller/notification_controller.dart';
import '../widget/notification_disabled_dialog.dart';

Future<void> notificationSwitchOnToggle(
    NotificationState state, BuildContext context) async {
  if (state.status == PermissionStatus.permanentlyDenied) {
    showDialog(
      context: context,
      builder: (context) => NotificationDisabledDialog(),
    );
  } else {
    if (state.status == PermissionStatus.granted) {
      await NotificationService().cancelAllNotifications();
    } else if (state.status == PermissionStatus.restricted) {
      await rescheduleAzans(context);
      await rescheduleVoluntaryFastingReminders(context);
    }
    BlocProvider.of<NotificationBloc>(context).add(
      ToggleNotification(),
    );
  }
}
