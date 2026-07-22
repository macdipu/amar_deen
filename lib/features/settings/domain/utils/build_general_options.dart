import 'package:flutter/widgets.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

import 'package:amar_deen/core/routing/app_router.dart';
import 'package:amar_deen/core/constants/constants.dart';
import 'package:amar_deen/core/utils/share_controller.dart';
import 'package:amar_deen/core/utils/url_launcher_controller.dart';
import '../entities/general_option_entity.dart';

/// Builds the Settings screen's "General" card rows. Not a pure top-level
/// const list - each row's title/subtitle is localized, so this needs a
/// [BuildContext] to resolve [AppLocalizations], same reasoning as home's
/// `build_collection_items.dart`.
List<GeneralOptionEntity> buildGeneralOptions(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  return [
    GeneralOptionEntity(
      imagePath: 'assets/images/collection_icon/svg/quran.svg',
      onTap: null,
      routeName: AppRoutes.quranSettings,
      title: l10n.settingQuranSettingsTitle,
      subtitle: l10n.settingQuranSettingsSubtitle,
    ),
    GeneralOptionEntity(
      imagePath: 'assets/images/home_icon/svg/fajr.svg',
      onTap: null,
      routeName: AppRoutes.prayerTimeSettings,
      title: l10n.settingPrayerTimeSettingsTitle,
      subtitle: l10n.settingPrayerTimeSettingsSubtitle,
    ),
    GeneralOptionEntity(
      imagePath: 'assets/images/setting_icon/svg/thank.svg',
      onTap: null,
      routeName: AppRoutes.thankyou,
      title: l10n.settingThankYouTitle,
      subtitle: l10n.settingThankYouSubtitle,
    ),
    GeneralOptionEntity(
      imagePath: 'assets/images/setting_icon/svg/star.svg',
      onTap: () async {
        await launchURL(PLAY_STORE_URL);
      },
      title: l10n.settingRateTitle,
      subtitle: l10n.settingRateSubtitle,
    ),
    GeneralOptionEntity(
      imagePath: 'assets/images/setting_icon/svg/share.svg',
      onTap: () async {
        await onShare('Hey! Checkout this app '
            'https://play.google.com/store/apps/details?id=com.devtechnologies.siratemustaqeem');
      },
      title: l10n.settingShareTitle,
      subtitle: l10n.settingShareSubtitle,
    ),
    GeneralOptionEntity(
      imagePath: 'assets/images/setting_icon/svg/donate.svg',
      onTap: () {},
      title: l10n.settingSupportTitle,
      subtitle: l10n.settingSupportSubtitle,
    ),
  ];
}
