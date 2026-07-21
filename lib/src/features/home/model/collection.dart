import 'package:flutter/widgets.dart';
import 'package:sirat_e_mustaqeem/l10n/generated/app_localizations.dart';

import '../../../../core/routing/app_router.dart';

class Collection {
  final String assetName;
  final String title;
  final String routeName;

  Collection(this.assetName, this.title, this.routeName);
}

List<Collection> buildCollections(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  return [
  Collection(
    'assets/images/collection_icon/svg/quran.svg',
    l10n.homeCollectionQuran,
    AppRoutes.quran,
  ),
  Collection(
    'assets/images/collection_icon/svg/hadees.svg',
    l10n.homeCollectionHadees,
    'Coming Soon',
  ),
  Collection(
    'assets/images/collection_icon/svg/duas.svg',
    l10n.homeCollectionDua,
    AppRoutes.dua,
  ),
  Collection(
    'assets/images/collection_icon/svg/tasbih.svg',
    l10n.homeCollectionTasbih,
    AppRoutes.tasbih,
  ),
  Collection(
    'assets/images/collection_icon/svg/other.svg',
    l10n.homeCollectionAzkars,
    AppRoutes.azkar,
  ),
  Collection(
    'assets/images/collection_icon/svg/allah.svg',
    l10n.homeCollectionAllahNames,
    AppRoutes.allahName,
  ),
  Collection(
    'assets/images/collection_icon/svg/prayer_time.svg',
    l10n.homeCollectionPrayerTimes,
    AppRoutes.prayerTimingPage,
  ),
  Collection(
    'assets/images/collection_icon/svg/prayer_time_1.svg',
    l10n.homeCollectionVoluntaryPrayers,
    AppRoutes.voluntaryPrayers,
  ),
  Collection(
    'assets/images/collection_icon/svg/ramadan.svg',
    l10n.homeCollectionRamadan,
    AppRoutes.ramadan,
  ),
  Collection(
    'assets/images/collection_icon/svg/zakat.svg',
    l10n.homeCollectionZakat,
    AppRoutes.zakatCalculator,
  ),
  Collection(
    'assets/images/collection_icon/svg/kiblat.svg',
    l10n.homeCollectionQiblaDirection,
    AppRoutes.qibla,
  ),
  Collection(
    'assets/images/collection_icon/svg/qaabah.svg',
    l10n.homeCollectionLiveTv,
    AppRoutes.liveTv,
  ),
  Collection(
    'assets/images/collection_icon/svg/other.svg',
    l10n.homeCollectionOthers,
    'Coming Soon',
  ),
  ];
}
