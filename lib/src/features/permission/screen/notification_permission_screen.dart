import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/routing/app_router.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/widgets/elevated_button.dart';

class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kPagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 500.h,
                  maxHeight: 0.5.sh,
                ),
                child: LottieBuilder.asset(
                  'assets/images/permission/lottie_json/notification_permission.json',
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Text(
                'Allow your notification',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                'We will need your notification to provide you better experience.',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 32.h,
              ),
              CustomElevatedButton(
                onPressed: () async {
                  await Permission.notification.request();
                  // Android 12+'s "Alarms & reminders" permission - lets Azan
                  // notifications fire at the exact prayer time rather than
                  // being delayed by the system. Requested here (once, during
                  // onboarding) rather than each time a notification is
                  // scheduled, since granting it opens a system Settings
                  // screen rather than an in-app dialog.
                  await Permission.scheduleExactAlarm.request();
                  context.pushReplacement(AppRoutes.tabScreen);
                },
                text: 'Sure, I like that',
              ),
              SizedBox(
                height: 8.h,
              ),
              TextButton(
                onPressed: () {
                  context.pushReplacement(AppRoutes.tabScreen);
                },
                child: Text(
                  'Not now',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
