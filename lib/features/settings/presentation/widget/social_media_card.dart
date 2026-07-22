import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

import 'package:amar_deen/core/widgets/sirat_card.dart';
import '../../domain/entities/social_media_entity.dart';
import 'social_media_button.dart';

class SocialMediaCard extends StatelessWidget {
  const SocialMediaCard();

  @override
  Widget build(BuildContext context) {
    return SiratCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).settingConnect,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 8.h),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: socialMediaList.length >= 3
                  ? List.generate(
                      3,
                      (index) {
                        return Expanded(
                          child: SocialMediaButton(
                            socialMediaList[index],
                          ),
                        );
                      },
                    )
                  : [
                      ...List.generate(
                        socialMediaList.length,
                        (index) {
                          return Expanded(
                            child: SocialMediaButton(
                              socialMediaList[index],
                            ),
                          );
                        },
                      ),
                      ...List.generate(
                        3 - socialMediaList.length,
                        (index) {
                          return Expanded(
                            child: Container(),
                          );
                        },
                      ),
                    ]),
          if (socialMediaList.length > 3)
            SizedBox(
              height: 16.h,
            ),
          if (socialMediaList.length > 3)
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: socialMediaList.length >= 6
                    ? List.generate(
                        3,
                        (index) {
                          return Expanded(
                            child: SocialMediaButton(
                              socialMediaList[index + 3],
                            ),
                          );
                        },
                      )
                    : [
                        ...List.generate(
                          socialMediaList.length - 3,
                          (index) {
                            return Expanded(
                              child: SocialMediaButton(
                                socialMediaList[index + 3],
                              ),
                            );
                          },
                        ),
                        ...List.generate(
                          6 - socialMediaList.length,
                          (index) {
                            return Expanded(
                              child: Container(),
                            );
                          },
                        ),
                      ])
        ],
      ),
    );
  }
}
