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
  String get settingDailyReminder => 'Daily Reminder';

  @override
  String get settingDailyReminderTime => 'Reminder time';

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
  String get prayerTimingAppBarTitle => 'Prayer Timing';

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
  String get homeCollectionRamadan => 'Ramadan';

  @override
  String get homeCollectionZakat => 'Zakat Calculator';

  @override
  String get homeCollectionQiblaDirection => 'Qabah Direction';

  @override
  String get homeCollectionLiveTv => 'Live TV';

  @override
  String get homeCollectionOthers => 'Others';

  @override
  String get bookmarkEmpty =>
      'You have not favorited or bookmarked any Qurans, Tasbihs or Duas.';

  @override
  String get qiblaTitle => 'Qiblah Direction';

  @override
  String get qiblaDirectionIs => 'Qiblah direction is ';

  @override
  String get qiblaDirectionNorth => 'North';

  @override
  String get qiblaDirectionNorthEast => 'North-East';

  @override
  String get qiblaDirectionEast => 'East';

  @override
  String get qiblaDirectionSouthEast => 'South-East';

  @override
  String get qiblaDirectionSouth => 'South';

  @override
  String get qiblaDirectionSouthWest => 'South-West';

  @override
  String get qiblaDirectionWest => 'West';

  @override
  String get qiblaDirectionNorthWest => 'North-West';

  @override
  String get liveTvWatch => 'Watch';

  @override
  String get liveTvNoInternet => 'No internet connection.';

  @override
  String get liveTvUnableToPlay => 'Unable to play this channel right now.';

  @override
  String get liveTvExitFullScreen => 'Exit full screen';

  @override
  String get liveTvEnterFullScreen => 'Full screen';

  @override
  String get liveTvLive => 'Live';

  @override
  String get liveTvPaused => 'Paused';

  @override
  String get azkarAppBarTitle => 'Azkars (Hisnul Muslim)';

  @override
  String get azkarFavoriteAzkars => 'Favorite Azkars';

  @override
  String get azkarNoCategoriesAvailable => 'No Azkar categories available.';

  @override
  String get azkarNoChaptersFound => 'No chapters found.';

  @override
  String get azkarNoItemsFound => 'No Azkars found.';

  @override
  String get azkarNoFavoritesYet => 'No favorite Azkars yet.';

  @override
  String get azkarLanguageEnglish => 'English';

  @override
  String get azkarLanguageArabic => 'Arabic';

  @override
  String get azkarLanguageKurdishSorani => 'Kurdish (Sorani)';

  @override
  String get azkarLanguageKurdishBadini => 'Kurdish (Badini)';

  @override
  String get azkarLanguagePersian => 'Persian';

  @override
  String get azkarLanguageRussian => 'Russian';

  @override
  String duaAyaLabel(int aya) {
    return 'Aya: $aya';
  }

  @override
  String get tasbihAddNew => 'Add New Tasbih';

  @override
  String get tasbihEditTitle => 'Edit Tasbih';

  @override
  String get tasbihActions => 'Actions:';

  @override
  String get tasbihCopy => 'Copy';

  @override
  String get tasbihNameHint => 'Input tasbih name here';

  @override
  String get tasbihNameEmptyError => 'Tashbih name cannot be empty';

  @override
  String get tasbihCountsLabel => 'Tasbih counts:';

  @override
  String get tasbihCountsHint => 'Input tasbih counts here';

  @override
  String get tasbihCounterEmptyError => 'Tashbih counter cannot be empty';

  @override
  String get tasbihCountsSuffix => 'counts';

  @override
  String get quranAppBarTitle => 'Al-Quran';

  @override
  String get quranTabSurah => 'Surah';

  @override
  String get quranTabJuz => 'Juz';

  @override
  String quranContinueReadingSurah(String surah) {
    return 'Continue Reading Surah $surah';
  }

  @override
  String quranContinueReadingJuz(String juz) {
    return 'Continue Reading $juz';
  }

  @override
  String get quranSearchAppBarTitle => 'Search Quran';

  @override
  String get quranSearchHint => 'Search by name, number, place…';

  @override
  String get quranSearchSurahsTitle => 'Search Surahs';

  @override
  String get quranSearchJuzTitle => 'Search Juz';

  @override
  String get quranNoResults => 'No results';

  @override
  String get quranSearchSurahsHintBody =>
      'Type a Surah name (English/Arabic) or number.';

  @override
  String get quranSearchJuzHintBody => 'Type a Juz name or number (e.g. “2”).';

  @override
  String quranSearchNoMatchSurah(String query) {
    return 'Nothing matched “$query”. Try a different spelling.';
  }

  @override
  String quranSearchNoMatchJuz(String query) {
    return 'Nothing matched “$query”. Try searching by number.';
  }

  @override
  String get quranCouldNotOpenVerse =>
      'Could not open this verse in the Quran.';

  @override
  String quranPlayingSurah(int surah) {
    return 'Playing Surah $surah';
  }

  @override
  String quranPlayingSurahAyah(int surah, int ayah) {
    return 'Playing Surah $surah • Ayah $ayah';
  }

  @override
  String quranPlayFullSurah(int surah) {
    return 'Play full Surah $surah';
  }

  @override
  String get quranAudioNoInternet => 'No internet connection. Please try again.';

  @override
  String get quranAudioPlaybackFailed => 'Unable to play audio right now.';

  @override
  String get quranAudioSurahPlaybackFailed =>
      'Unable to play surah audio right now.';

  @override
  String quranSurahMeta(String place, int ayats) {
    return '$place - $ayats ayat';
  }

  @override
  String get quranPlaceMakki => 'Meccan';

  @override
  String get quranPlaceMadina => 'Medinan';

  @override
  String get quranOptionAppBarTitle => 'Quran Styling Option';

  @override
  String get quranOptionAudioReciter => 'Audio reciter';

  @override
  String get quranOptionShowTranslation => 'Show translation';

  @override
  String get quranOptionQuranFontSize => 'Quran font size';

  @override
  String get quranOptionQuranFontFamily => 'Quran font family';

  @override
  String get quranOptionTranslationFontSize => 'Translation font size';

  @override
  String get quranOptionTranslationFontFamily => 'Translation font family';

  @override
  String get quranOptionTranslationMode => 'Translation mode';

  @override
  String get quranOptionQuranType => 'Quran type';

  @override
  String get quranOptionQcfScrollDirection => 'QCF scroll direction';

  @override
  String get quranTypeNormal => 'Normal';

  @override
  String get quranScrollDirectionVertical => 'Vertical';

  @override
  String get quranScrollDirectionHorizontal => 'Horizontal';

  @override
  String get quranAudioTypeVerseByVerse => 'Verse by verse';

  @override
  String get quranAudioTypeTranslation => 'Translation';

  @override
  String get quranLangArabic => 'Arabic';

  @override
  String get quranLangEnglish => 'English';

  @override
  String get quranLangUrdu => 'Urdu';

  @override
  String get quranLangPersian => 'Persian';

  @override
  String get quranLangFrench => 'French';

  @override
  String get quranLangRussian => 'Russian';

  @override
  String get quranLangChinese => 'Chinese';

  @override
  String quranAudioMetaLine(String type, String language, int quality) {
    return 'Type: $type • Language: $language • Quality: $quality kbps';
  }

  @override
  String get errorLocationDisabled =>
      'Location is not enabled. Please go to setting to enable it.';

  @override
  String get errorReadDatabaseFailed => 'Read database failed. Try again later.';

  @override
  String get errorConnectionInterrupted =>
      'Connection interrupted. Please reconnect to the internet.';

  @override
  String get quranTranslationModeUrdu => 'Urdu';

  @override
  String get quranTranslationModeEnglishSaheeh => 'English (Saheeh)';

  @override
  String get quranTranslationModeEnglishClearQuran => 'English (Clear Quran)';

  @override
  String get quranTranslationModeTurkishSaheeh => 'Turkish (Saheeh)';

  @override
  String get quranTranslationModeMalayalamAbdulHameed =>
      'Malayalam (Abdul Hameed)';

  @override
  String get quranTranslationModePersianHusseinDari =>
      'Persian (Hussein Dari)';

  @override
  String get quranTranslationModeFrenchHamidullah => 'French (Hamidullah)';

  @override
  String get quranTranslationModeItalianPiccardo => 'Italian (Piccardo)';

  @override
  String get quranTranslationModeDutchSiregar => 'Dutch (Siregar)';

  @override
  String get quranTranslationModePortuguese => 'Portuguese';

  @override
  String get quranTranslationModeRussianKuliev => 'Russian (Kuliev)';

  @override
  String get quranTranslationModeBengali => 'Bengali';

  @override
  String get quranTranslationModeIndonesian => 'Indonesian';

  @override
  String get quranTranslationModeChinese => 'Chinese';

  @override
  String get quranTranslationModeSpanish => 'Spanish';

  @override
  String get quranTranslationModeSwedish => 'Swedish';

  @override
  String get ramadanAppBarTitle => 'Ramadan';

  @override
  String get ramadanSuhoorTitle => 'Suhoor';

  @override
  String get ramadanSuhoorSubtitle => 'Ends at Imsak, shortly before Fajr.';

  @override
  String get ramadanIftarTitle => 'Iftar';

  @override
  String get ramadanIftarSubtitle => 'Breaking the fast, at Maghrib.';

  @override
  String get ramadanSuhoorEndsIn => 'Suhoor ends in ';

  @override
  String get ramadanIftarIn => 'Iftar is in ';

  @override
  String azanNotificationTitle(String prayer) {
    return '$prayer Azan';
  }

  @override
  String azanNotificationBody(String prayer) {
    return 'It is time for $prayer prayer.';
  }

  @override
  String get voluntaryFastingSectionTitle => 'Upcoming Voluntary Fasts';

  @override
  String get voluntaryFastingMonday => 'Monday Fast';

  @override
  String get voluntaryFastingThursday => 'Thursday Fast';

  @override
  String get voluntaryFastingAyyamAlBeed => 'Ayyam al-Beed (White Days)';

  @override
  String get voluntaryFastingArafah => 'Day of Arafah';

  @override
  String voluntaryFastingReminderTitle(String fastingDay) {
    return '$fastingDay tomorrow';
  }

  @override
  String get voluntaryFastingReminderBody =>
      'Tomorrow is a recommended day to fast. Plan your Suhoor and intention (niyyah) tonight.';

  @override
  String get zakatAppBarTitle => 'Zakat Calculator';

  @override
  String get zakatDisclaimer =>
      'This calculator uses the silver Nisab standard and assumes your wealth has been held for a full lunar year (Hawl). For a precise ruling, consult a qualified scholar.';

  @override
  String get zakatCashLabel => 'Cash & Bank Savings';

  @override
  String get zakatGoldWeightLabel => 'Gold Weight (grams)';

  @override
  String get zakatGoldPriceLabel => 'Gold Price per Gram';

  @override
  String get zakatSilverWeightLabel => 'Silver Weight (grams)';

  @override
  String get zakatSilverPriceLabel => 'Silver Price per Gram';

  @override
  String get zakatBusinessAssetsLabel => 'Business Assets';

  @override
  String get zakatInvestmentsLabel => 'Other Investments';

  @override
  String get zakatDebtsLabel => 'Debts Owed';

  @override
  String get zakatCalculateButton => 'Calculate Zakat';

  @override
  String get zakatResultZakatableWealth => 'Zakatable Wealth';

  @override
  String get zakatResultNisabThreshold => 'Nisab Threshold (Silver Standard)';

  @override
  String get zakatResultDue => 'Zakat is due';

  @override
  String get zakatResultNotDue => 'Zakat is not due — wealth is below Nisab';

  @override
  String get zakatResultAmount => 'Zakat Amount (2.5%)';

  @override
  String get dailyReminderNotificationTitle => 'Sirate Mustaqeem reminder';

  @override
  String get dailyReminderNotificationBody =>
      'Take a moment for Quran reading, Dhikr, or to check today\'s prayer times.';
}
