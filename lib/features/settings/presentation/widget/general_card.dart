import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

import 'package:amar_deen/core/widgets/sirat_card.dart';
import '../../domain/utils/build_general_options.dart';
import 'general_option_card.dart';

class GeneralCard extends StatelessWidget {
  const GeneralCard();

  @override
  Widget build(BuildContext context) {
    final generalOptions = buildGeneralOptions(context);
    return SiratCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).settingGeneral,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 8.h),
          ...List.generate(
            generalOptions.length,
            (index) => Column(
              children: [
                if (index != 0) Divider(),
                GeneralOptionCard(
                  imagePath: generalOptions[index].imagePath,
                  onTap: generalOptions[index].onTap ??
                      () {
                        context.push(generalOptions[index].routeName!);
                      },
                  title: generalOptions[index].title,
                  subtitle: generalOptions[index].subtitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
