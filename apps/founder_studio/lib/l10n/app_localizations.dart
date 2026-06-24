import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
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
/// import 'l10n/app_localizations.dart';
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
    Locale('ar'),
    Locale('en'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Founder Studio'**
  String get appTitle;

  /// Splash screen loading message
  ///
  /// In en, this message translates to:
  /// **'Loading Founder Studio…'**
  String get splashLoading;

  /// No description provided for @healthTitle.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get healthTitle;

  /// No description provided for @healthStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get healthStatusLabel;

  /// No description provided for @healthStatusOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get healthStatusOk;

  /// No description provided for @healthStatusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get healthStatusUnknown;

  /// No description provided for @healthBackendLabel.
  ///
  /// In en, this message translates to:
  /// **'Backend'**
  String get healthBackendLabel;

  /// No description provided for @healthBackendReachable.
  ///
  /// In en, this message translates to:
  /// **'Reachable'**
  String get healthBackendReachable;

  /// No description provided for @healthBackendUnreachable.
  ///
  /// In en, this message translates to:
  /// **'Unreachable'**
  String get healthBackendUnreachable;

  /// No description provided for @navHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get navHealth;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue building your venture'**
  String get loginSubtitle;

  /// No description provided for @loginEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginEmailLabel;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordLabel;

  /// No description provided for @loginEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get loginEmailRequired;

  /// No description provided for @loginPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get loginPasswordRequired;

  /// No description provided for @loginAction.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginAction;

  /// No description provided for @logoutAction.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get logoutAction;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsThemeLabel.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsThemeLabel;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageLabel;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get languageArabic;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get profileNameLabel;

  /// No description provided for @profileStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get profileStatusLabel;

  /// No description provided for @profileActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get profileActive;

  /// No description provided for @profileInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get profileInactive;

  /// No description provided for @profilePlaceholderNote.
  ///
  /// In en, this message translates to:
  /// **'Extended profile management will be available in a future release.'**
  String get profilePlaceholderNote;

  /// No description provided for @connectionChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking connection…'**
  String get connectionChecking;

  /// No description provided for @connectionOnline.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connectionOnline;

  /// No description provided for @connectionOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get connectionOffline;

  /// No description provided for @backendVersionLabel.
  ///
  /// In en, this message translates to:
  /// **'Backend version'**
  String get backendVersionLabel;

  /// No description provided for @backendVersionUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get backendVersionUnavailable;

  /// No description provided for @emptyProjectsTitle.
  ///
  /// In en, this message translates to:
  /// **'No projects yet'**
  String get emptyProjectsTitle;

  /// No description provided for @emptyProjectsDescription.
  ///
  /// In en, this message translates to:
  /// **'Create your first venture project to get started with Founder Studio.'**
  String get emptyProjectsDescription;

  /// No description provided for @emptyProjectsAction.
  ///
  /// In en, this message translates to:
  /// **'Create project'**
  String get emptyProjectsAction;

  /// No description provided for @projectSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search projects…'**
  String get projectSearchHint;

  /// No description provided for @projectNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get projectNameLabel;

  /// No description provided for @projectNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Project name is required'**
  String get projectNameRequired;

  /// No description provided for @projectDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get projectDescriptionLabel;

  /// No description provided for @projectStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get projectStatusLabel;

  /// No description provided for @projectStatusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get projectStatusDraft;

  /// No description provided for @projectStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get projectStatusActive;

  /// No description provided for @projectStatusOnHold.
  ///
  /// In en, this message translates to:
  /// **'On hold'**
  String get projectStatusOnHold;

  /// No description provided for @projectStatusArchived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get projectStatusArchived;

  /// No description provided for @projectColorLabel.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get projectColorLabel;

  /// No description provided for @projectIconLabel.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get projectIconLabel;

  /// No description provided for @createProjectTitle.
  ///
  /// In en, this message translates to:
  /// **'Create project'**
  String get createProjectTitle;

  /// No description provided for @createProjectAction.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createProjectAction;

  /// No description provided for @editProjectTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit project'**
  String get editProjectTitle;

  /// No description provided for @editProjectAction.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editProjectAction;

  /// No description provided for @saveProjectAction.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveProjectAction;

  /// No description provided for @deleteProjectTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete project'**
  String get deleteProjectTitle;

  /// No description provided for @deleteProjectMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"? This cannot be undone.'**
  String deleteProjectMessage(String name);

  /// No description provided for @deleteProjectAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteProjectAction;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// No description provided for @projectLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load projects'**
  String get projectLoadError;

  /// No description provided for @retryAction.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryAction;

  /// No description provided for @projectUpdatedLabel.
  ///
  /// In en, this message translates to:
  /// **'Updated {date}'**
  String projectUpdatedLabel(String date);
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
