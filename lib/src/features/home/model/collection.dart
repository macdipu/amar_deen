import '../../../../core/routing/app_router.dart';

class Collection {
  final String assetName;
  final String title;
  final String routeName;

  Collection(this.assetName, this.title, this.routeName);
}

List<Collection> collections = [
  Collection(
    'assets/images/collection_icon/svg/quran.svg',
    'Quran',
    AppRoutes.quran,
  ),
  Collection(
    'assets/images/collection_icon/svg/hadees.svg',
    'Hadees',
    'Coming Soon',
  ),
  Collection(
    'assets/images/collection_icon/svg/duas.svg',
    'Dua',
    AppRoutes.dua,
  ),
  Collection(
    'assets/images/collection_icon/svg/tasbih.svg',
    'Tasbih',
    AppRoutes.tasbih,
  ),
  Collection(
    'assets/images/collection_icon/svg/other.svg',
    'Azkars',
    AppRoutes.azkar,
  ),
  Collection(
    'assets/images/collection_icon/svg/allah.svg',
    '99 Names of Allah',
    AppRoutes.allahName,
  ),
  Collection(
    'assets/images/collection_icon/svg/prayer_time.svg',
    'Prayer Times',
    AppRoutes.prayerTimingPage,
  ),
  Collection(
    'assets/images/collection_icon/svg/kiblat.svg',
    'Qabah Direction',
    AppRoutes.qibla,
  ),
  Collection(
    'assets/images/collection_icon/svg/qaabah.svg',
    'Live TV',
    AppRoutes.liveTv,
  ),
  Collection(
    'assets/images/collection_icon/svg/other.svg',
    'Others',
    'Coming Soon',
  ),
];
