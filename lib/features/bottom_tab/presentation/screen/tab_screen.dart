import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:amar_deen/core/notifications/notification_service.dart';
import 'package:amar_deen/core/bloc/location/location_bloc.dart';
import 'package:amar_deen/core/bloc/notification/notification_bloc.dart';
import 'package:amar_deen/features/prayer_times/presentation/bloc/timing_bloc/timing_bloc.dart';
import 'package:amar_deen/core/utils/notification_controller.dart';
import 'package:amar_deen/core/widgets/loading_widget.dart';
import 'package:amar_deen/features/bottom_tab/presentation/widget/tab_scaffold.dart';

class TabScreen extends StatefulWidget {
  const TabScreen();

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    configureDidReceiveLocalNotificationSubject(context);
    configureSelectNotificationSubject(context);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (Platform.isAndroid)
      Future.delayed(Duration(milliseconds: 500), () {
        if (state == AppLifecycleState.resumed) {
          BlocProvider.of<TimingBloc>(context).add(UpdateTiming());
        }
      });
    else if (Platform.isIOS) {
      if (state == AppLifecycleState.resumed) {
        BlocProvider.of<NotificationBloc>(context).add(UpdateNotification());

        BlocProvider.of<TimingBloc>(context).add(UpdateTiming());

        /// wait for updateNotification to finish
        Future.delayed(Duration(milliseconds: 500), () {
          if (BlocProvider.of<NotificationBloc>(context).state.status ==
              PermissionStatus.granted) {
            rescheduleAzans(context);
            rescheduleVoluntaryFastingReminders(context);
            rescheduleDailyReminder(context);
          } else {
            NotificationService().cancelAllNotifications();
          }
        });
      }
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void didChangeDependencies() {
    final locationState = BlocProvider.of<LocationBloc>(context).state;
    if (locationState is! LocationSuccess &&
        locationState is! LocationLoading) {
      BlocProvider.of<LocationBloc>(context).add(InitLocation());
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is LocationLoading) {
          return Scaffold(
            body: LoadingWidget(),
          );
        }
        return TabScaffold();
      },
    );
  }
}
