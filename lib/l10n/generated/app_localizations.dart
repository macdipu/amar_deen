import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en')
  ];

  /// Bottom navigation label for the Home tab
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Bottom navigation label for the Search tab
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get navSearch;

  /// Bottom navigation label for the Quran tab
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get navQuran;

  /// Bottom navigation label for the Bookmark tab
  ///
  /// In en, this message translates to:
  /// **'Bookmark'**
  String get navBookmark;

  /// Bottom navigation label for the Settings tab
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get navSetting;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get commonSomethingWentWrong;

  /// No description provided for @commonLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get commonLoading;

  /// No description provided for @homeLocationSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get homeLocationSheetTitle;

  /// No description provided for @homeLocationSheetBody.
  ///
  /// In en, this message translates to:
  /// **'Prayer times use your saved location. To change it, update location permission and accuracy in your device settings.'**
  String get homeLocationSheetBody;

  /// No description provided for @homeLocationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Location unavailable'**
  String get homeLocationUnavailable;

  /// No description provided for @settingAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingAppBarTitle;

  /// No description provided for @settingAppBarSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure your experience'**
  String get settingAppBarSubtitle;

  /// No description provided for @settingUserPreferences.
  ///
  /// In en, this message translates to:
  /// **'User Preferences'**
  String get settingUserPreferences;

  /// No description provided for @settingTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingTheme;

  /// No description provided for @settingTimeFormat.
  ///
  /// In en, this message translates to:
  /// **'Time Format'**
  String get settingTimeFormat;

  /// No description provided for @settingNotification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get settingNotification;

  /// No description provided for @settingLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingLanguage;

  /// No description provided for @settingGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingGeneral;

  /// No description provided for @settingConnect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get settingConnect;

  /// No description provided for @settingQuranSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quran settings'**
  String get settingQuranSettingsTitle;

  /// No description provided for @settingQuranSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Customize Quran font, translation mode and styling.'**
  String get settingQuranSettingsSubtitle;

  /// No description provided for @settingPrayerTimeSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer time settings'**
  String get settingPrayerTimeSettingsTitle;

  /// No description provided for @settingPrayerTimeSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure calculation method, school and Hijri adjustment.'**
  String get settingPrayerTimeSettingsSubtitle;

  /// No description provided for @settingThankYouTitle.
  ///
  /// In en, this message translates to:
  /// **'Thank you'**
  String get settingThankYouTitle;

  /// No description provided for @settingThankYouSubtitle.
  ///
  /// In en, this message translates to:
  /// **'These generous contributors helped make this app a reality!'**
  String get settingThankYouSubtitle;

  /// No description provided for @settingRateTitle.
  ///
  /// In en, this message translates to:
  /// **'Rate on App Store'**
  String get settingRateTitle;

  /// No description provided for @settingRateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enjoy using \'Sirate Mustaqeem\'? Please leave a review to help other Muslims.'**
  String get settingRateSubtitle;

  /// No description provided for @settingShareTitle.
  ///
  /// In en, this message translates to:
  /// **'Share with a friend'**
  String get settingShareTitle;

  /// No description provided for @settingShareSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell others about the app with a link.'**
  String get settingShareSubtitle;

  /// No description provided for @settingSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Support this project'**
  String get settingSupportTitle;

  /// No description provided for @settingSupportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Support \'Dev Technologies\' project to benefit other Muslims.'**
  String get settingSupportSubtitle;

  /// No description provided for @settingThankYouAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Thank You!'**
  String get settingThankYouAppBarTitle;

  /// No description provided for @settingThankYouBody.
  ///
  /// In en, this message translates to:
  /// **'These generous Sirate Mustaqeem contributors helped to make this app a reality!'**
  String get settingThankYouBody;

  /// No description provided for @settingNotificationDeniedBody.
  ///
  /// In en, this message translates to:
  /// **'You have denied the notification permission previously. Please go to app setting to enabled it.'**
  String get settingNotificationDeniedBody;

  /// No description provided for @settingGoToAppSettings.
  ///
  /// In en, this message translates to:
  /// **'To app setting'**
  String get settingGoToAppSettings;

  /// No description provided for @permissionLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow your location'**
  String get permissionLocationTitle;

  /// No description provided for @permissionLocationBody.
  ///
  /// In en, this message translates to:
  /// **'We will need your location to provide you better experience.'**
  String get permissionLocationBody;

  /// No description provided for @permissionNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow your notification'**
  String get permissionNotificationTitle;

  /// No description provided for @permissionNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'We will need your notification to provide you better experience.'**
  String get permissionNotificationBody;

  /// No description provided for @permissionAllow.
  ///
  /// In en, this message translates to:
  /// **'Sure, I like that'**
  String get permissionAllow;

  /// No description provided for @permissionNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get permissionNotNow;

  /// No description provided for @prayerFajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get prayerFajr;

  /// No description provided for @prayerSunrise.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get prayerSunrise;

  /// No description provided for @prayerDhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get prayerDhuhr;

  /// No description provided for @prayerAsr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get prayerAsr;

  /// No description provided for @prayerMaghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get prayerMaghrib;

  /// No description provided for @prayerIsha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get prayerIsha;

  /// No description provided for @prayerDuha.
  ///
  /// In en, this message translates to:
  /// **'Duha'**
  String get prayerDuha;

  /// No description provided for @prayerIshraq.
  ///
  /// In en, this message translates to:
  /// **'Ishraq'**
  String get prayerIshraq;

  /// No description provided for @prayerTahajjud.
  ///
  /// In en, this message translates to:
  /// **'Tahajjud'**
  String get prayerTahajjud;

  /// No description provided for @homeLessThanAMinute.
  ///
  /// In en, this message translates to:
  /// **'less than a minute'**
  String get homeLessThanAMinute;

  /// No description provided for @homeMinutesRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{0 minutes} one{{count} minute} other{{count} minutes}}'**
  String homeMinutesRemaining(int count);

  /// No description provided for @homeHoursRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} hour} other{{count} hours}}'**
  String homeHoursRemaining(int count);

  /// No description provided for @homePrayerIsAwayFrom.
  ///
  /// In en, this message translates to:
  /// **'{prayer} is only away from '**
  String homePrayerIsAwayFrom(String prayer);

  /// No description provided for @voluntaryPrayersTitle.
  ///
  /// In en, this message translates to:
  /// **'Voluntary Prayers'**
  String get voluntaryPrayersTitle;

  /// No description provided for @voluntaryIshraqTitle.
  ///
  /// In en, this message translates to:
  /// **'Ishraq'**
  String get voluntaryIshraqTitle;

  /// No description provided for @voluntaryIshraqSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Shortly after sunrise, once the sun has fully risen.'**
  String get voluntaryIshraqSubtitle;

  /// No description provided for @voluntaryDuhaTitle.
  ///
  /// In en, this message translates to:
  /// **'Duha (Chasht)'**
  String get voluntaryDuhaTitle;

  /// No description provided for @voluntaryDuhaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Mid-morning, until shortly before Dhuhr.'**
  String get voluntaryDuhaSubtitle;

  /// No description provided for @voluntaryTahajjudTitle.
  ///
  /// In en, this message translates to:
  /// **'Tahajjud'**
  String get voluntaryTahajjudTitle;

  /// No description provided for @voluntaryTahajjudSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Last third of the night - the most virtuous time for voluntary night prayer.'**
  String get voluntaryTahajjudSubtitle;

  /// No description provided for @prayerWindowFrom.
  ///
  /// In en, this message translates to:
  /// **'{prayer} — from {start}'**
  String prayerWindowFrom(String prayer, String start);

  /// No description provided for @prayerWindowRange.
  ///
  /// In en, this message translates to:
  /// **'{prayer} — {start} to {end}'**
  String prayerWindowRange(String prayer, String start, String end);

  /// No description provided for @prayerSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer time settings'**
  String get prayerSettingsTitle;

  /// No description provided for @prayerSettingsCalculationMethod.
  ///
  /// In en, this message translates to:
  /// **'Calculation method'**
  String get prayerSettingsCalculationMethod;

  /// No description provided for @prayerSettingsAsrSchool.
  ///
  /// In en, this message translates to:
  /// **'Asr school'**
  String get prayerSettingsAsrSchool;

  /// No description provided for @prayerSettingsDayOffset.
  ///
  /// In en, this message translates to:
  /// **'Prayer day offset'**
  String get prayerSettingsDayOffset;

  /// No description provided for @prayerSettingsHijriAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Hijri date adjustment'**
  String get prayerSettingsHijriAdjustment;

  /// No description provided for @prayerSettingsResetToDefaults.
  ///
  /// In en, this message translates to:
  /// **'Reset to defaults'**
  String get prayerSettingsResetToDefaults;

  /// No description provided for @prayerSettingsAzanReminders.
  ///
  /// In en, this message translates to:
  /// **'Azan reminders'**
  String get prayerSettingsAzanReminders;

  /// No description provided for @commonComingSoon.
  ///
  /// In en, this message translates to:
  /// **'The team is working on this feature and it will be available soon. Stay tuned!'**
  String get commonComingSoon;

  /// No description provided for @homeAyatOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'Quran Ayat of the Day'**
  String get homeAyatOfTheDay;

  /// No description provided for @homeSurahAyahLabel.
  ///
  /// In en, this message translates to:
  /// **'Surah {surah} - Ayah {ayah}'**
  String homeSurahAyahLabel(String surah, int ayah);

  /// No description provided for @homeHadeesOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'Hadees of the Day'**
  String get homeHadeesOfTheDay;

  /// No description provided for @homeHadeesOfTheDayText.
  ///
  /// In en, this message translates to:
  /// **'\"A Muslim is a brother of another Muslim, so he should not oppress him, nor should he hand him over to an oppressor. Whoever has fulfilled the needs of his brother, Allah will fulfil his needs; whoever has brought his (Muslim) brother out of a discomfort, Allah will bring him out of the discomforts of the Day of Resurrection, and whoever has screened a Muslim, Allah will screen him(of his faults) on the Day of Resurrection.\"'**
  String get homeHadeesOfTheDayText;

  /// No description provided for @homeHadeesOfTheDayAttribution.
  ///
  /// In en, this message translates to:
  /// **'- Prophet Muhammad (PBUH)'**
  String get homeHadeesOfTheDayAttribution;

  /// No description provided for @homeHadeesOfTheDaySource.
  ///
  /// In en, this message translates to:
  /// **'Bukhari, Mazalim (Injustices), 3'**
  String get homeHadeesOfTheDaySource;

  /// No description provided for @homeCollectionSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Collection'**
  String get homeCollectionSectionTitle;

  /// No description provided for @homeCollectionQuran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get homeCollectionQuran;

  /// No description provided for @homeCollectionHadees.
  ///
  /// In en, this message translates to:
  /// **'Hadees'**
  String get homeCollectionHadees;

  /// No description provided for @homeCollectionDua.
  ///
  /// In en, this message translates to:
  /// **'Dua'**
  String get homeCollectionDua;

  /// No description provided for @homeCollectionTasbih.
  ///
  /// In en, this message translates to:
  /// **'Tasbih'**
  String get homeCollectionTasbih;

  /// No description provided for @homeCollectionAzkars.
  ///
  /// In en, this message translates to:
  /// **'Azkars'**
  String get homeCollectionAzkars;

  /// No description provided for @homeCollectionAllahNames.
  ///
  /// In en, this message translates to:
  /// **'99 Names of Allah'**
  String get homeCollectionAllahNames;

  /// No description provided for @homeCollectionPrayerTimes.
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get homeCollectionPrayerTimes;

  /// No description provided for @homeCollectionVoluntaryPrayers.
  ///
  /// In en, this message translates to:
  /// **'Voluntary Prayers'**
  String get homeCollectionVoluntaryPrayers;

  /// No description provided for @homeCollectionQiblaDirection.
  ///
  /// In en, this message translates to:
  /// **'Qabah Direction'**
  String get homeCollectionQiblaDirection;

  /// No description provided for @homeCollectionLiveTv.
  ///
  /// In en, this message translates to:
  /// **'Live TV'**
  String get homeCollectionLiveTv;

  /// No description provided for @homeCollectionOthers.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get homeCollectionOthers;

  /// No description provided for @bookmarkEmpty.
  ///
  /// In en, this message translates to:
  /// **'You have not favorited or bookmarked any Qurans, Tasbihs or Duas.'**
  String get bookmarkEmpty;

  /// No description provided for @qiblaTitle.
  ///
  /// In en, this message translates to:
  /// **'Qiblah Direction'**
  String get qiblaTitle;

  /// No description provided for @qiblaDirectionIs.
  ///
  /// In en, this message translates to:
  /// **'Qiblah direction is '**
  String get qiblaDirectionIs;

  /// No description provided for @qiblaDirectionNorth.
  ///
  /// In en, this message translates to:
  /// **'North'**
  String get qiblaDirectionNorth;

  /// No description provided for @qiblaDirectionNorthEast.
  ///
  /// In en, this message translates to:
  /// **'North-East'**
  String get qiblaDirectionNorthEast;

  /// No description provided for @qiblaDirectionEast.
  ///
  /// In en, this message translates to:
  /// **'East'**
  String get qiblaDirectionEast;

  /// No description provided for @qiblaDirectionSouthEast.
  ///
  /// In en, this message translates to:
  /// **'South-East'**
  String get qiblaDirectionSouthEast;

  /// No description provided for @qiblaDirectionSouth.
  ///
  /// In en, this message translates to:
  /// **'South'**
  String get qiblaDirectionSouth;

  /// No description provided for @qiblaDirectionSouthWest.
  ///
  /// In en, this message translates to:
  /// **'South-West'**
  String get qiblaDirectionSouthWest;

  /// No description provided for @qiblaDirectionWest.
  ///
  /// In en, this message translates to:
  /// **'West'**
  String get qiblaDirectionWest;

  /// No description provided for @qiblaDirectionNorthWest.
  ///
  /// In en, this message translates to:
  /// **'North-West'**
  String get qiblaDirectionNorthWest;

  /// No description provided for @liveTvWatch.
  ///
  /// In en, this message translates to:
  /// **'Watch'**
  String get liveTvWatch;

  /// No description provided for @liveTvNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection.'**
  String get liveTvNoInternet;

  /// No description provided for @liveTvUnableToPlay.
  ///
  /// In en, this message translates to:
  /// **'Unable to play this channel right now.'**
  String get liveTvUnableToPlay;

  /// No description provided for @liveTvExitFullScreen.
  ///
  /// In en, this message translates to:
  /// **'Exit full screen'**
  String get liveTvExitFullScreen;

  /// No description provided for @liveTvLive.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get liveTvLive;

  /// No description provided for @liveTvPaused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get liveTvPaused;

  /// No description provided for @azkarAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Azkars (Hisnul Muslim)'**
  String get azkarAppBarTitle;

  /// No description provided for @azkarFavoriteAzkars.
  ///
  /// In en, this message translates to:
  /// **'Favorite Azkars'**
  String get azkarFavoriteAzkars;

  /// No description provided for @azkarNoCategoriesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Azkar categories available.'**
  String get azkarNoCategoriesAvailable;

  /// No description provided for @azkarNoChaptersFound.
  ///
  /// In en, this message translates to:
  /// **'No chapters found.'**
  String get azkarNoChaptersFound;

  /// No description provided for @azkarNoItemsFound.
  ///
  /// In en, this message translates to:
  /// **'No Azkars found.'**
  String get azkarNoItemsFound;

  /// No description provided for @azkarNoFavoritesYet.
  ///
  /// In en, this message translates to:
  /// **'No favorite Azkars yet.'**
  String get azkarNoFavoritesYet;

  /// No description provided for @azkarLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get azkarLanguageEnglish;

  /// No description provided for @azkarLanguageArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get azkarLanguageArabic;

  /// No description provided for @azkarLanguageKurdishSorani.
  ///
  /// In en, this message translates to:
  /// **'Kurdish (Sorani)'**
  String get azkarLanguageKurdishSorani;

  /// No description provided for @azkarLanguageKurdishBadini.
  ///
  /// In en, this message translates to:
  /// **'Kurdish (Badini)'**
  String get azkarLanguageKurdishBadini;

  /// No description provided for @azkarLanguagePersian.
  ///
  /// In en, this message translates to:
  /// **'Persian'**
  String get azkarLanguagePersian;

  /// No description provided for @azkarLanguageRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get azkarLanguageRussian;

  /// No description provided for @duaAyaLabel.
  ///
  /// In en, this message translates to:
  /// **'Aya: {aya}'**
  String duaAyaLabel(int aya);

  /// No description provided for @tasbihAddNew.
  ///
  /// In en, this message translates to:
  /// **'Add New Tasbih'**
  String get tasbihAddNew;

  /// No description provided for @tasbihEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Tasbih'**
  String get tasbihEditTitle;

  /// No description provided for @tasbihActions.
  ///
  /// In en, this message translates to:
  /// **'Actions:'**
  String get tasbihActions;

  /// No description provided for @tasbihCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get tasbihCopy;

  /// No description provided for @tasbihNameHint.
  ///
  /// In en, this message translates to:
  /// **'Input tasbih name here'**
  String get tasbihNameHint;

  /// No description provided for @tasbihNameEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Tashbih name cannot be empty'**
  String get tasbihNameEmptyError;

  /// No description provided for @tasbihCountsLabel.
  ///
  /// In en, this message translates to:
  /// **'Tasbih counts:'**
  String get tasbihCountsLabel;

  /// No description provided for @tasbihCountsHint.
  ///
  /// In en, this message translates to:
  /// **'Input tasbih counts here'**
  String get tasbihCountsHint;

  /// No description provided for @tasbihCounterEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Tashbih counter cannot be empty'**
  String get tasbihCounterEmptyError;

  /// No description provided for @tasbihCountsSuffix.
  ///
  /// In en, this message translates to:
  /// **'counts'**
  String get tasbihCountsSuffix;

  /// No description provided for @quranAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Al-Quran'**
  String get quranAppBarTitle;

  /// No description provided for @quranTabSurah.
  ///
  /// In en, this message translates to:
  /// **'Surah'**
  String get quranTabSurah;

  /// No description provided for @quranTabJuz.
  ///
  /// In en, this message translates to:
  /// **'Juz'**
  String get quranTabJuz;

  /// No description provided for @quranContinueReadingSurah.
  ///
  /// In en, this message translates to:
  /// **'Continue Reading Surah {surah}'**
  String quranContinueReadingSurah(String surah);

  /// No description provided for @quranContinueReadingJuz.
  ///
  /// In en, this message translates to:
  /// **'Continue Reading {juz}'**
  String quranContinueReadingJuz(String juz);

  /// No description provided for @quranSearchAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Search Quran'**
  String get quranSearchAppBarTitle;

  /// No description provided for @quranSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name, number, place…'**
  String get quranSearchHint;

  /// No description provided for @quranSearchSurahsTitle.
  ///
  /// In en, this message translates to:
  /// **'Search Surahs'**
  String get quranSearchSurahsTitle;

  /// No description provided for @quranSearchJuzTitle.
  ///
  /// In en, this message translates to:
  /// **'Search Juz'**
  String get quranSearchJuzTitle;

  /// No description provided for @quranNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get quranNoResults;

  /// No description provided for @quranSearchSurahsHintBody.
  ///
  /// In en, this message translates to:
  /// **'Type a Surah name (English/Arabic) or number.'**
  String get quranSearchSurahsHintBody;

  /// No description provided for @quranSearchJuzHintBody.
  ///
  /// In en, this message translates to:
  /// **'Type a Juz name or number (e.g. “2”).'**
  String get quranSearchJuzHintBody;

  /// No description provided for @quranSearchNoMatchSurah.
  ///
  /// In en, this message translates to:
  /// **'Nothing matched “{query}”. Try a different spelling.'**
  String quranSearchNoMatchSurah(String query);

  /// No description provided for @quranSearchNoMatchJuz.
  ///
  /// In en, this message translates to:
  /// **'Nothing matched “{query}”. Try searching by number.'**
  String quranSearchNoMatchJuz(String query);

  /// No description provided for @quranCouldNotOpenVerse.
  ///
  /// In en, this message translates to:
  /// **'Could not open this verse in the Quran.'**
  String get quranCouldNotOpenVerse;

  /// No description provided for @quranPlayingSurah.
  ///
  /// In en, this message translates to:
  /// **'Playing Surah {surah}'**
  String quranPlayingSurah(int surah);

  /// No description provided for @quranPlayingSurahAyah.
  ///
  /// In en, this message translates to:
  /// **'Playing Surah {surah} • Ayah {ayah}'**
  String quranPlayingSurahAyah(int surah, int ayah);

  /// No description provided for @quranPlayFullSurah.
  ///
  /// In en, this message translates to:
  /// **'Play full Surah {surah}'**
  String quranPlayFullSurah(int surah);

  /// No description provided for @quranAudioNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please try again.'**
  String get quranAudioNoInternet;

  /// No description provided for @quranAudioPlaybackFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to play audio right now.'**
  String get quranAudioPlaybackFailed;

  /// No description provided for @quranAudioSurahPlaybackFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to play surah audio right now.'**
  String get quranAudioSurahPlaybackFailed;

  /// No description provided for @quranSurahMeta.
  ///
  /// In en, this message translates to:
  /// **'{place} - {ayats} ayat'**
  String quranSurahMeta(String place, int ayats);

  /// No description provided for @quranPlaceMakki.
  ///
  /// In en, this message translates to:
  /// **'Meccan'**
  String get quranPlaceMakki;

  /// No description provided for @quranPlaceMadina.
  ///
  /// In en, this message translates to:
  /// **'Medinan'**
  String get quranPlaceMadina;

  /// No description provided for @quranOptionAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Quran Styling Option'**
  String get quranOptionAppBarTitle;

  /// No description provided for @quranOptionAudioReciter.
  ///
  /// In en, this message translates to:
  /// **'Audio reciter'**
  String get quranOptionAudioReciter;

  /// No description provided for @quranOptionShowTranslation.
  ///
  /// In en, this message translates to:
  /// **'Show translation'**
  String get quranOptionShowTranslation;

  /// No description provided for @quranOptionQuranFontSize.
  ///
  /// In en, this message translates to:
  /// **'Quran font size'**
  String get quranOptionQuranFontSize;

  /// No description provided for @quranOptionQuranFontFamily.
  ///
  /// In en, this message translates to:
  /// **'Quran font family'**
  String get quranOptionQuranFontFamily;

  /// No description provided for @quranOptionTranslationFontSize.
  ///
  /// In en, this message translates to:
  /// **'Translation font size'**
  String get quranOptionTranslationFontSize;

  /// No description provided for @quranOptionTranslationFontFamily.
  ///
  /// In en, this message translates to:
  /// **'Translation font family'**
  String get quranOptionTranslationFontFamily;

  /// No description provided for @quranOptionTranslationMode.
  ///
  /// In en, this message translates to:
  /// **'Translation mode'**
  String get quranOptionTranslationMode;

  /// No description provided for @quranOptionQuranType.
  ///
  /// In en, this message translates to:
  /// **'Quran type'**
  String get quranOptionQuranType;

  /// No description provided for @quranOptionQcfScrollDirection.
  ///
  /// In en, this message translates to:
  /// **'QCF scroll direction'**
  String get quranOptionQcfScrollDirection;

  /// No description provided for @quranTypeNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get quranTypeNormal;

  /// No description provided for @quranScrollDirectionVertical.
  ///
  /// In en, this message translates to:
  /// **'Vertical'**
  String get quranScrollDirectionVertical;

  /// No description provided for @quranScrollDirectionHorizontal.
  ///
  /// In en, this message translates to:
  /// **'Horizontal'**
  String get quranScrollDirectionHorizontal;

  /// No description provided for @quranAudioTypeVerseByVerse.
  ///
  /// In en, this message translates to:
  /// **'Verse by verse'**
  String get quranAudioTypeVerseByVerse;

  /// No description provided for @quranAudioTypeTranslation.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get quranAudioTypeTranslation;

  /// No description provided for @quranLangArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get quranLangArabic;

  /// No description provided for @quranLangEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get quranLangEnglish;

  /// No description provided for @quranLangUrdu.
  ///
  /// In en, this message translates to:
  /// **'Urdu'**
  String get quranLangUrdu;

  /// No description provided for @quranLangPersian.
  ///
  /// In en, this message translates to:
  /// **'Persian'**
  String get quranLangPersian;

  /// No description provided for @quranLangFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get quranLangFrench;

  /// No description provided for @quranLangRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get quranLangRussian;

  /// No description provided for @quranLangChinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get quranLangChinese;

  /// No description provided for @quranAudioMetaLine.
  ///
  /// In en, this message translates to:
  /// **'Type: {type} • Language: {language} • Quality: {quality} kbps'**
  String quranAudioMetaLine(String type, String language, int quality);

  /// No description provided for @errorLocationDisabled.
  ///
  /// In en, this message translates to:
  /// **'Location is not enabled. Please go to setting to enable it.'**
  String get errorLocationDisabled;

  /// No description provided for @errorReadDatabaseFailed.
  ///
  /// In en, this message translates to:
  /// **'Read database failed. Try again later.'**
  String get errorReadDatabaseFailed;

  /// No description provided for @errorConnectionInterrupted.
  ///
  /// In en, this message translates to:
  /// **'Connection interrupted. Please reconnect to the internet.'**
  String get errorConnectionInterrupted;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
