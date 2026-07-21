import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sirat_e_mustaqeem/l10n/generated/app_localizations.dart';

import '../../../core/error/error_code.dart';
import '../../../core/error/failures.dart';

/// Maps a [RemoteFailure]'s numeric [RemoteFailure.errorCode] to localized
/// display text - see the equivalent note on [LocalFailureContent]'s
/// `_localizedMessage`.
String _localizedMessage(BuildContext context, RemoteFailure failure) {
  final l10n = AppLocalizations.of(context);
  switch (failure.errorCode) {
    case RemoteErrorCode.INTERNET_ERROR_CODE:
      return l10n.liveTvNoInternet;
    case RemoteErrorCode.CONNECTION_INTERUPTED_ERROR_CODE:
      return l10n.errorConnectionInterrupted;
    default:
      return l10n.commonSomethingWentWrong;
  }
}

class RemoteFailureContent extends StatelessWidget {
  const RemoteFailureContent(this.failure);

  final RemoteFailure failure;

  @override
  Widget build(BuildContext context) {
    if (failure.errorCode == RemoteErrorCode.INTERNET_ERROR_CODE) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 500.w,
            ),
            child: ClipOval(
              child: LottieBuilder.asset(
                'assets/images/error/lottie_json/no_internet.json',
              ),
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
