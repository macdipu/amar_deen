import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'package:sirat_e_mustaqeem/l10n/generated/app_localizations.dart';

import '../../core/util/constants.dart';

class ComingSoonDialog extends StatelessWidget {
  const ComingSoonDialog();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: kPagePadding,
        padding: EdgeInsets.symmetric(
          vertical: 48.h,
          horizontal: 16.w,
        ),
        decoration: BoxDecoration(
          borderRadius: kCardBorderRadius,
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500.w),
              child: LottieBuilder.asset(
                'assets/images/error/lottie_json/construction.json',
              ),
            ),
            Text(
              AppLocalizations.of(context).commonComingSoon,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
