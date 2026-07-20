import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sirat_e_mustaqeem/l10n/generated/app_localizations.dart';

import '../../../../core/routing/app_router.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/widgets/elevated_button.dart';

class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
                l10n.permissionNotificationTitle,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                l10n.permissionNotificationBody,
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
                text: l10n.permissionAllow,
              ),
              SizedBox(
                height: 8.h,
              ),
              TextButton(
                onPressed: () {
                  context.pushReplacement(AppRoutes.tabScreen);
                },
                child: Text(l10n.permissionNotNow),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
