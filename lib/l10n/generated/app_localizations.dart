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
