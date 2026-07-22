import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

import 'package:amar_deen/core/di/injection.dart';
import 'package:amar_deen/core/routing/app_router.dart';
import 'package:amar_deen/core/constants/constants.dart';
import 'package:amar_deen/core/widgets/elevated_button.dart';
import '../../domain/usecases/request_exact_alarm_permission.dart';
import '../../domain/usecases/request_notification_permission.dart';

class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final requestNotificationPermission =
        getIt<RequestNotificationPermission>();
    final requestExactAlarmPermission = getIt<RequestExactAlarmPermission>();
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
                  await requestNotificationPermission();
                  // Requested here (once, during onboarding) rather than
                  // each time a notification is scheduled, since granting
                  // it opens a system Settings screen rather than an
                  // in-app dialog.
                  await requestExactAlarmPermission();
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
