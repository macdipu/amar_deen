import 'package:flutter/widgets.dart';
import 'package:sirat_e_mustaqeem/l10n/generated/app_localizations.dart';

import '../../../../core/routing/app_router.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/controller/share_controller.dart';
import '../../../core/util/controller/url_launcher_controller.dart';

class GeneralOption {
  final String imagePath;
  final String? routeName;
  final Function()? onTap;
  final String title;
  final String subtitle;

  GeneralOption({
    required this.imagePath,
    required this.onTap,
    required this.title,
    required this.subtitle,
    this.routeName,
  });
}

List<GeneralOption> buildGeneralOptions(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  return [
    GeneralOption(
      imagePath: 'assets/images/collection_icon/svg/quran.svg',
      onTap: null,
      routeName: AppRoutes.quranSettings,
      title: l10n.settingQuranSettingsTitle,
      subtitle: l10n.settingQuranSettingsSubtitle,
    ),
    GeneralOption(
      imagePath: 'assets/images/home_icon/svg/fajr.svg',
      onTap: null,
      routeName: AppRoutes.prayerTimeSettings,
      title: l10n.settingPrayerTimeSettingsTitle,
      subtitle: l10n.settingPrayerTimeSettingsSubtitle,
    ),
    GeneralOption(
      imagePath: 'assets/images/setting_icon/svg/thank.svg',
      onTap: null,
      routeName: AppRoutes.thankyou,
      title: l10n.settingThankYouTitle,
      subtitle: l10n.settingThankYouSubtitle,
    ),
    GeneralOption(
      imagePath: 'assets/images/setting_icon/svg/star.svg',
      onTap: () async {
        await launchURL(PLAY_STORE_URL);
      },
      title: l10n.settingRateTitle,
      subtitle: l10n.settingRateSubtitle,
    ),
    GeneralOption(
      imagePath: 'assets/images/setting_icon/svg/share.svg',
      onTap: () async {
        await onShare('Hey! Checkout this app '
            'https://play.google.com/store/apps/details?id=com.devtechnologies.siratemustaqeem');
      },
      title: l10n.settingShareTitle,
      subtitle: l10n.settingShareSubtitle,
    ),
    GeneralOption(
      imagePath: 'assets/images/setting_icon/svg/donate.svg',
      onTap: () {},
      title: l10n.settingSupportTitle,
      subtitle: l10n.settingSupportSubtitle,
    ),
  ];
}
