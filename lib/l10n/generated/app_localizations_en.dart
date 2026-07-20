// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navSearch => 'Search';

  @override
  String get navQuran => 'Quran';

  @override
  String get navBookmark => 'Bookmark';

  @override
  String get navSetting => 'Setting';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonClose => 'Close';

  @override
  String get commonSomethingWentWrong => 'Something went wrong.';

  @override
  String get commonLoading => 'Loading...';

  @override
  String get homeLocationSheetTitle => 'Location';

  @override
  String get homeLocationSheetBody =>
      'Prayer times use your saved location. To change it, update location permission and accuracy in your device settings.';

  @override
  String get homeLocationUnavailable => 'Location unavailable';

  @override
  String get settingAppBarTitle => 'Settings';

  @override
  String get settingAppBarSubtitle => 'Configure your experience';

  @override
  String get settingUserPreferences => 'User Preferences';

  @override
  String get settingTheme => 'Theme';

  @override
  String get settingTimeFormat => 'Time Format';

  @override
  String get settingNotification => 'Notification';

  @override
  String get settingLanguage => 'Language';

  @override
  String get settingGeneral => 'General';

  @override
  String get settingConnect => 'Connect';

  @override
  String get settingQuranSettingsTitle => 'Quran settings';

  @override
  String get settingQuranSettingsSubtitle =>
      'Customize Quran font, translation mode and styling.';

  @override
  String get settingPrayerTimeSettingsTitle => 'Prayer time settings';

  @override
  String get settingPrayerTimeSettingsSubtitle =>
      'Configure calculation method, school and Hijri adjustment.';

  @override
  String get settingThankYouTitle => 'Thank you';

  @override
  String get settingThankYouSubtitle =>
      'These generous contributors helped make this app a reality!';

  @override
  String get settingRateTitle => 'Rate on App Store';

  @override
  String get settingRateSubtitle =>
      'Enjoy using \'Sirate Mustaqeem\'? Please leave a review to help other Muslims.';

  @override
  String get settingShareTitle => 'Share with a friend';

  @override
  String get settingShareSubtitle => 'Tell others about the app with a link.';

  @override
  String get settingSupportTitle => 'Support this project';

  @override
  String get settingSupportSubtitle =>
      'Support \'Dev Technologies\' project to benefit other Muslims.';

  @override
  String get settingThankYouAppBarTitle => 'Thank You!';

  @override
  String get settingThankYouBody =>
      'These generous Sirate Mustaqeem contributors helped to make this app a reality!';

  @override
  String get settingNotificationDeniedBody =>
      'You have denied the notification permission previously. Please go to app setting to enabled it.';

  @override
  String get settingGoToAppSettings => 'To app setting';

  @override
  String get permissionLocationTitle => 'Allow your location';

  @override
  String get permissionLocationBody =>
      'We will need your location to provide you better experience.';

  @override
  String get permissionNotificationTitle => 'Allow your notification';

  @override
  String get permissionNotificationBody =>
      'We will need your notification to provide you better experience.';

  @override
  String get permissionAllow => 'Sure, I like that';

  @override
  String get permissionNotNow => 'Not now';

  @override
  String get prayerFajr => 'Fajr';

  @override
  String get prayerSunrise => 'Sunrise';

  @override
  String get prayerDhuhr => 'Dhuhr';

  @override
  String get prayerAsr => 'Asr';

  @override
  String get prayerMaghrib => 'Maghrib';

  @override
  String get prayerIsha => 'Isha';

  @override
  String get prayerDuha => 'Duha';

  @override
  String get prayerIshraq => 'Ishraq';

  @override
  String get prayerTahajjud => 'Tahajjud';

  @override
  String get homeLessThanAMinute => 'less than a minute';

  @override
  String homeMinutesRemaining(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes',
      one: '$count minute',
      zero: '0 minutes',
    );
    return '$_temp0';
  }

  @override
  String homeHoursRemaining(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours',
      one: '$count hour',
    );
    return '$_temp0';
  }

  @override
  String homePrayerIsAwayFrom(String prayer) {
    return '$prayer is only away from ';
  }

  @override
  String get voluntaryPrayersTitle => 'Voluntary Prayers';

  @override
  String get voluntaryIshraqTitle => 'Ishraq';

  @override
  String get voluntaryIshraqSubtitle =>
      'Shortly after sunrise, once the sun has fully risen.';

  @override
  String get voluntaryDuhaTitle => 'Duha (Chasht)';

  @override
  String get voluntaryDuhaSubtitle =>
      'Mid-morning, until shortly before Dhuhr.';

  @override
  String get voluntaryTahajjudTitle => 'Tahajjud';

  @override
  String get voluntaryTahajjudSubtitle =>
      'Last third of the night - the most virtuous time for voluntary night prayer.';

  @override
  String prayerWindowFrom(String prayer, String start) {
    return '$prayer — from $start';
  }

  @override
  String prayerWindowRange(String prayer, String start, String end) {
    return '$prayer — $start to $end';
  }

  @override
  String get prayerSettingsTitle => 'Prayer time settings';

  @override
  String get prayerSettingsCalculationMethod => 'Calculation method';

  @override
  String get prayerSettingsAsrSchool => 'Asr school';

  @override
  String get prayerSettingsDayOffset => 'Prayer day offset';

  @override
  String get prayerSettingsHijriAdjustment => 'Hijri date adjustment';

  @override
  String get prayerSettingsResetToDefaults => 'Reset to defaults';

  @override
  String get prayerSettingsAzanReminders => 'Azan reminders';

  @override
  String get commonComingSoon =>
      'The team is working on this feature and it will be available soon. Stay tuned!';

  @override
  String get homeAyatOfTheDay => 'Quran Ayat of the Day';

  @override
  String homeSurahAyahLabel(String surah, int ayah) {
    return 'Surah $surah - Ayah $ayah';
  }

  @override
  String get homeHadeesOfTheDay => 'Hadees of the Day';

  @override
  String get homeHadeesOfTheDayText =>
      '\"A Muslim is a brother of another Muslim, so he should not oppress him, nor should he hand him over to an oppressor. Whoever has fulfilled the needs of his brother, Allah will fulfil his needs; whoever has brought his (Muslim) brother out of a discomfort, Allah will bring him out of the discomforts of the Day of Resurrection, and whoever has screened a Muslim, Allah will screen him(of his faults) on the Day of Resurrection.\"';

  @override
  String get homeHadeesOfTheDayAttribution => '- Prophet Muhammad (PBUH)';

  @override
  String get homeHadeesOfTheDaySource => 'Bukhari, Mazalim (Injustices), 3';

  @override
  String get homeCollectionSectionTitle => 'Collection';

  @override
  String get homeCollectionQuran => 'Quran';

  @override
  String get homeCollectionHadees => 'Hadees';

  @override
  String get homeCollectionDua => 'Dua';

  @override
  String get homeCollectionTasbih => 'Tasbih';

  @override
  String get homeCollectionAzkars => 'Azkars';

  @override
  String get homeCollectionAllahNames => '99 Names of Allah';

  @override
  String get homeCollectionPrayerTimes => 'Prayer Times';

  @override
  String get homeCollectionVoluntaryPrayers => 'Voluntary Prayers';

  @override
  String get homeCollectionQiblaDirection => 'Qabah Direction';

  @override
  String get homeCollectionLiveTv => 'Live TV';

  @override
  String get homeCollectionOthers => 'Others';
}
