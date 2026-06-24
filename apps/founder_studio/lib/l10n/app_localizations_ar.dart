// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'استوديو المؤسس';

  @override
  String get splashLoading => 'جاري تحميل استوديو المؤسس…';

  @override
  String get healthTitle => 'الحالة';

  @override
  String get healthStatusLabel => 'الحالة';

  @override
  String get healthStatusOk => 'سليم';

  @override
  String get healthStatusUnknown => 'غير معروف';

  @override
  String get healthBackendLabel => 'الخادم';

  @override
  String get healthBackendReachable => 'متاح';

  @override
  String get healthBackendUnreachable => 'غير متاح';

  @override
  String get navHealth => 'الحالة';

  @override
  String get navDashboard => 'لوحة التحكم';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get loginSubtitle => 'سجّل الدخول لمتابعة بناء مشروعك';

  @override
  String get loginEmailLabel => 'البريد الإلكتروني';

  @override
  String get loginPasswordLabel => 'كلمة المرور';

  @override
  String get loginEmailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get loginPasswordRequired => 'كلمة المرور مطلوبة';

  @override
  String get loginAction => 'تسجيل الدخول';

  @override
  String get logoutAction => 'تسجيل الخروج';

  @override
  String get dismiss => 'إغلاق';

  @override
  String get dashboardTitle => 'لوحة التحكم';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsThemeLabel => 'المظهر';

  @override
  String get settingsThemeSystem => 'النظام';

  @override
  String get settingsThemeLight => 'فاتح';

  @override
  String get settingsThemeDark => 'داكن';

  @override
  String get settingsLanguageLabel => 'اللغة';

  @override
  String get languageEnglish => 'الإنجليزية';

  @override
  String get languageArabic => 'العربية';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get profileNameLabel => 'الاسم';

  @override
  String get profileStatusLabel => 'الحالة';

  @override
  String get profileActive => 'نشط';

  @override
  String get profileInactive => 'غير نشط';

  @override
  String get profilePlaceholderNote =>
      'ستتوفر إدارة الملف الشخصي الموسعة في إصدار لاحق.';

  @override
  String get connectionChecking => 'جاري التحقق من الاتصال…';

  @override
  String get connectionOnline => 'متصل';

  @override
  String get connectionOffline => 'غير متصل';

  @override
  String get backendVersionLabel => 'إصدار الخادم';

  @override
  String get backendVersionUnavailable => 'غير متاح';

  @override
  String get emptyProjectsTitle => 'لا توجد مشاريع بعد';

  @override
  String get emptyProjectsDescription =>
      'أنشئ مشروعك الأول للبدء مع استوديو المؤسس.';

  @override
  String get emptyProjectsAction => 'إنشاء مشروع';

  @override
  String get projectSearchHint => 'البحث في المشاريع…';

  @override
  String get projectNameLabel => 'الاسم';

  @override
  String get projectNameRequired => 'اسم المشروع مطلوب';

  @override
  String get projectDescriptionLabel => 'الوصف';

  @override
  String get projectStatusLabel => 'الحالة';

  @override
  String get projectStatusDraft => 'مسودة';

  @override
  String get projectStatusActive => 'نشط';

  @override
  String get projectStatusOnHold => 'معلق';

  @override
  String get projectStatusArchived => 'مؤرشف';

  @override
  String get projectColorLabel => 'اللون';

  @override
  String get projectIconLabel => 'الأيقونة';

  @override
  String get createProjectTitle => 'إنشاء مشروع';

  @override
  String get createProjectAction => 'إنشاء';

  @override
  String get editProjectTitle => 'تعديل المشروع';

  @override
  String get editProjectAction => 'تعديل';

  @override
  String get saveProjectAction => 'حفظ';

  @override
  String get deleteProjectTitle => 'حذف المشروع';

  @override
  String deleteProjectMessage(String name) {
    return 'حذف \"$name\"؟ لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get deleteProjectAction => 'حذف';

  @override
  String get cancelAction => 'إلغاء';

  @override
  String get projectLoadError => 'تعذر تحميل المشاريع';

  @override
  String get retryAction => 'إعادة المحاولة';

  @override
  String projectUpdatedLabel(String date) {
    return 'تم التحديث $date';
  }
}
