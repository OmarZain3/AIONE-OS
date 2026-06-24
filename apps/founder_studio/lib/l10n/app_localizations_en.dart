// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Founder Studio';

  @override
  String get splashLoading => 'Loading Founder Studio…';

  @override
  String get healthTitle => 'Health';

  @override
  String get healthStatusLabel => 'Status';

  @override
  String get healthStatusOk => 'OK';

  @override
  String get healthStatusUnknown => 'Unknown';

  @override
  String get healthBackendLabel => 'Backend';

  @override
  String get healthBackendReachable => 'Reachable';

  @override
  String get healthBackendUnreachable => 'Unreachable';

  @override
  String get navHealth => 'Health';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navSettings => 'Settings';

  @override
  String get navProfile => 'Profile';

  @override
  String get loginSubtitle => 'Sign in to continue building your venture';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginEmailRequired => 'Email is required';

  @override
  String get loginPasswordRequired => 'Password is required';

  @override
  String get loginAction => 'Sign in';

  @override
  String get logoutAction => 'Sign out';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsThemeLabel => 'Theme';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsLanguageLabel => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'Arabic';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileNameLabel => 'Name';

  @override
  String get profileStatusLabel => 'Status';

  @override
  String get profileActive => 'Active';

  @override
  String get profileInactive => 'Inactive';

  @override
  String get profilePlaceholderNote =>
      'Extended profile management will be available in a future release.';

  @override
  String get connectionChecking => 'Checking connection…';

  @override
  String get connectionOnline => 'Connected';

  @override
  String get connectionOffline => 'Offline';

  @override
  String get backendVersionLabel => 'Backend version';

  @override
  String get backendVersionUnavailable => 'Unavailable';

  @override
  String get emptyProjectsTitle => 'No projects yet';

  @override
  String get emptyProjectsDescription =>
      'Create your first venture project to get started with Founder Studio.';

  @override
  String get emptyProjectsAction => 'Create project';

  @override
  String get projectSearchHint => 'Search projects…';

  @override
  String get projectNameLabel => 'Name';

  @override
  String get projectNameRequired => 'Project name is required';

  @override
  String get projectDescriptionLabel => 'Description';

  @override
  String get projectStatusLabel => 'Status';

  @override
  String get projectStatusDraft => 'Draft';

  @override
  String get projectStatusActive => 'Active';

  @override
  String get projectStatusOnHold => 'On hold';

  @override
  String get projectStatusArchived => 'Archived';

  @override
  String get projectColorLabel => 'Color';

  @override
  String get projectIconLabel => 'Icon';

  @override
  String get createProjectTitle => 'Create project';

  @override
  String get createProjectAction => 'Create';

  @override
  String get editProjectTitle => 'Edit project';

  @override
  String get editProjectAction => 'Edit';

  @override
  String get saveProjectAction => 'Save';

  @override
  String get deleteProjectTitle => 'Delete project';

  @override
  String deleteProjectMessage(String name) {
    return 'Delete \"$name\"? This cannot be undone.';
  }

  @override
  String get deleteProjectAction => 'Delete';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get projectLoadError => 'Unable to load projects';

  @override
  String get retryAction => 'Retry';

  @override
  String projectUpdatedLabel(String date) {
    return 'Updated $date';
  }
}
