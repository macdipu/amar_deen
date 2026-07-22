import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'package:amar_deen/core/error/error_code.dart';
import 'package:amar_deen/core/error/failures.dart';
import 'package:amar_deen/core/utils/location_controller.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

/// Maps a [LocalFailure]'s numeric [LocalFailure.error] code to localized
/// display text, rather than showing [LocalFailure.message] directly - that
/// field is authored at the (context-less) bloc/controller call site and is
/// sometimes just a raw `Exception.toString()`, which can't be localized.
String _localizedMessage(BuildContext context, LocalFailure failure) {
  final l10n = AppLocalizations.of(context);
  switch (failure.error) {
    case 1:
      return l10n.errorLocationDisabled;
    case 2:
      return l10n.errorReadDatabaseFailed;
    case 3:
      return l10n.liveTvNoInternet;
    default:
      return l10n.commonSomethingWentWrong;
  }
}

class LocalFailureContent extends StatelessWidget {
  const LocalFailureContent(this.failure);

  final LocalFailure failure;

  @override
  Widget build(BuildContext context) {
    if (failure.error == kLocationDisableForever['errorCode'])
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 500.w,
            ),
            child: LottieBuilder.asset(
              'assets/images/error/lottie_json/no_gps.json',
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            _localizedMessage(context, failure),
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8.h,
          ),
          GestureDetector(
            onTap: () async => await openLocationSetting(),
            child: Text(AppLocalizations.of(context).settingGoToAppSettings),
          ),
          if (failure.extraInfo != null)
            Column(
              children: [
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  failure.extraInfo!,
                  textAlign: TextAlign.center,
                ),
              ],
            )
        ],
      );
    if (failure.error == kReadDatabaseFailed['errorCode']) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 500.w,
            ),
            child: LottieBuilder.asset(
              'assets/images/error/lottie_json/database_error.json',
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            _localizedMessage(context, failure),
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          if (failure.extraInfo != null)
            Column(
              children: [
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  failure.extraInfo!,
                  textAlign: TextAlign.center,
                ),
              ],
            )
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 500.w,
          ),
          child: LottieBuilder.asset(
            'assets/images/error/lottie_json/general_error.json',
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Text(
          _localizedMessage(context, failure),
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
