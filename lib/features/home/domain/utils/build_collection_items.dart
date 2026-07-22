import 'package:flutter/widgets.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

import 'package:amar_deen/core/routing/app_router.dart';
import '../entities/collection_item_entity.dart';

/// Builds the home screen's collection-grid tiles. Not a pure top-level
/// const list - each tile's title is localized, so this needs a
/// [BuildContext] to resolve [AppLocalizations], same reasoning as
/// `qibla`'s `direction_text.dart` domain-utils precedent but with the
/// BuildContext-taking signature preserved since l10n requires it here.
List<CollectionItemEntity> buildCollectionItems(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  return [
    CollectionItemEntity(
      'assets/images/collection_icon/svg/quran.svg',
      l10n.homeCollectionQuran,
      AppRoutes.quran,
    ),
    CollectionItemEntity(
      'assets/images/collection_icon/svg/hadees.svg',
      l10n.homeCollectionHadees,
      'Coming Soon',
    ),
    CollectionItemEntity(
      'assets/images/collection_icon/svg/duas.svg',
      l10n.homeCollectionDua,
      AppRoutes.dua,
    ),
    CollectionItemEntity(
      'assets/images/collection_icon/svg/tasbih.svg',
      l10n.homeCollectionTasbih,
      AppRoutes.tasbih,
    ),
    CollectionItemEntity(
      'assets/images/collection_icon/svg/other.svg',
      l10n.homeCollectionAzkars,
      AppRoutes.azkar,
    ),
    CollectionItemEntity(
      'assets/images/collection_icon/svg/allah.svg',
      l10n.homeCollectionAllahNames,
      AppRoutes.allahName,
    ),
    CollectionItemEntity(
      'assets/images/collection_icon/svg/prayer_time.svg',
      l10n.homeCollectionPrayerTimes,
      AppRoutes.prayerTimingPage,
    ),
    CollectionItemEntity(
      'assets/images/collection_icon/svg/prayer_time_1.svg',
      l10n.homeCollectionVoluntaryPrayers,
      AppRoutes.voluntaryPrayers,
    ),
    CollectionItemEntity(
      'assets/images/collection_icon/svg/ramadan.svg',
      l10n.homeCollectionRamadan,
      AppRoutes.ramadan,
    ),
    CollectionItemEntity(
      'assets/images/collection_icon/svg/zakat.svg',
      l10n.homeCollectionZakat,
      AppRoutes.zakatCalculator,
    ),
    CollectionItemEntity(
      'assets/images/collection_icon/svg/kiblat.svg',
      l10n.homeCollectionQiblaDirection,
      AppRoutes.qibla,
    ),
    CollectionItemEntity(
      'assets/images/collection_icon/svg/qaabah.svg',
      l10n.homeCollectionLiveTv,
      AppRoutes.liveTv,
    ),
    CollectionItemEntity(
      'assets/images/collection_icon/svg/other.svg',
      l10n.homeCollectionOthers,
      'Coming Soon',
    ),
  ];
}
