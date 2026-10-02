// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'مدرسة مسك';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navSessions => 'حصصي';

  @override
  String get navSync => 'المزامنة';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get navDashboard => 'لوحة المتابعة';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get loginSubtitle => 'فضاء المعلمين';

  @override
  String get loginWithGoogle => 'الدخول بحساب Google';

  @override
  String get loginOr => 'أو';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get pinLabel => 'الرمز السري (5 أرقام)';

  @override
  String get loginWithPin => 'الدخول بالرمز السري';

  @override
  String get pinInvalidFormat => 'يجب أن يتكون الرمز السري من 5 أرقام بالضبط.';

  @override
  String get emailInvalid => 'عنوان بريد إلكتروني غير صالح.';

  @override
  String get fieldHifz => 'الحفظ';

  @override
  String get fieldTajwid => 'التجويد';

  @override
  String get fieldDiscipline => 'الانضباط';

  @override
  String get fieldPresence => 'الحضور';

  @override
  String get fieldRemark => 'الملاحظة';

  @override
  String get fieldStudent => 'التلميذ';

  @override
  String get present => 'حاضر';

  @override
  String get absent => 'غائب';

  @override
  String get notEvaluated => 'غير مقيّم';

  @override
  String get statusDraft => 'مسودة';

  @override
  String get statusReady => 'جاهزة للإرسال';

  @override
  String get statusSent => 'مُرسلة';

  @override
  String get statusSynced => 'متزامنة';

  @override
  String get statusNeedsCorrection => 'للتصحيح';

  @override
  String get statusValidated => 'معتمدة';

  @override
  String get statusNotSent => 'غير مُرسلة';

  @override
  String get statusNotPrepared => 'غير مُهيّأة';

  @override
  String homeGreeting(String name) {
    return 'مرحبًا $name';
  }

  @override
  String get homeSelectedSession => 'الحصة المختارة';

  @override
  String get homeNoSession => 'لا توجد حصة متاحة حاليًا.';

  @override
  String get start => 'ابدأ';

  @override
  String get continueAction => 'متابعة';

  @override
  String get viewAction => 'عرض';

  @override
  String get chooseAnotherSession => 'اختيار حصة أخرى';

  @override
  String sessionTitle(String date) {
    return 'حصة $date';
  }

  @override
  String sessionNumber(int number) {
    return 'الحصة رقم $number';
  }

  @override
  String get groupLabel => 'المجموعة';

  @override
  String get sessionLabel => 'الحصة';

  @override
  String get savedLocally => 'محفوظ على الجهاز';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count تعديل غير متزامن',
      many: '$count تعديلًا غير متزامن',
      few: '$count تعديلات غير متزامنة',
      two: 'تعديلان غير متزامنين',
      one: 'تعديل واحد غير متزامن',
      zero: 'لا توجد تعديلات غير متزامنة',
    );
    return '$_temp0';
  }

  @override
  String pendingUploads(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عملية إرسال معلّقة',
      many: '$count عملية إرسال معلّقة',
      few: '$count عمليات إرسال معلّقة',
      two: 'إرسالان معلّقان',
      one: 'إرسال واحد معلّق',
      zero: 'لا يوجد إرسال معلّق',
    );
    return '$_temp0';
  }

  @override
  String get reviewSession => 'مراجعة الحصة';

  @override
  String get reviewTitle => 'المراجعة قبل الإرسال';

  @override
  String get send => 'إرسال';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get close => 'إغلاق';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get reload => 'إعادة تحميل الحصة';

  @override
  String get confirmSendTitle => 'تأكيد الإرسال';

  @override
  String get confirmSendMessage => 'هل أنت متأكد من إرسال درجات هذه الحصة؟';

  @override
  String get syncSuccess => 'تمت مزامنة الدرجات';

  @override
  String get queuedOffline =>
      'لا يوجد اتصال: سيتم الإرسال عند عودة الشبكة. درجاتك محفوظة.';

  @override
  String get summaryStudents => 'التلاميذ';

  @override
  String get summaryPresent => 'الحاضرون';

  @override
  String get summaryAbsent => 'الغائبون';

  @override
  String get summaryNotEvaluated => 'درجات غير مقيّمة';

  @override
  String get summaryDisciplineRemarks => 'ملاحظات الانضباط';

  @override
  String get summaryBlocking => 'أخطاء يجب تصحيحها';

  @override
  String get issueMissingRemark => 'الملاحظة إلزامية: الانضباط أقل من 7.';

  @override
  String get issueInvalidGrade => 'درجة غير صالحة: من 0 إلى 10 بخطوة 0.25.';

  @override
  String get issueAbsentWithGrade => 'تلميذ غائب: يجب أن تكون الدرجات «--».';

  @override
  String get issueNotEvaluated => 'درجة غير مقيّمة.';

  @override
  String get issueDuplicate => 'تلميذ مكرر.';

  @override
  String get issueNoStudents => 'لا يوجد تلاميذ في هذه الحصة.';

  @override
  String get lockedMessage =>
      'تم اعتماد هذه الحصة من طرف الإدارة ولا يمكن تعديلها.';

  @override
  String get pendingUploadMessage =>
      'الإرسال معلّق: ألغِ الإرسال لتعديل الحصة.';

  @override
  String get cancelUpload => 'إلغاء الإرسال';

  @override
  String correctionRequested(String comment) {
    return 'تصحيح مطلوب: $comment';
  }

  @override
  String get previousStudent => 'التلميذ السابق';

  @override
  String get nextStudent => 'التلميذ التالي';

  @override
  String get remarkHint => 'ملاحظة حرة';

  @override
  String get remarkRequiredHint => 'إلزامية: الانضباط أقل من 7';

  @override
  String get gradeInputHint => 'من 0 إلى 10 بخطوة 0.25';

  @override
  String get decrease => 'إنقاص 0.25';

  @override
  String get increase => 'زيادة 0.25';

  @override
  String get sessionsEmpty => 'لا توجد حصص متاحة.';

  @override
  String get noClass => 'لا توجد دروس';

  @override
  String get syncNow => 'مزامنة الآن';

  @override
  String get syncUpToDate => 'كل شيء متزامن';

  @override
  String lastSync(String date) {
    return 'آخر مزامنة: $date';
  }

  @override
  String get neverSynced => 'لم تتم مزامنتها بعد';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageArabic => 'العربية';

  @override
  String get settingsSimulateOffline => 'محاكاة انقطاع الشبكة (تجريبي)';

  @override
  String get settingsAccount => 'الحساب';

  @override
  String get logoutPendingMessage =>
      'هناك عمليات إرسال معلّقة. تسجيل الخروج سيحذف هذه الدرجات من الجهاز.';

  @override
  String get logoutAnyway => 'تسجيل الخروج على أي حال';

  @override
  String get conflictTitle => 'تم تعديل الحصة من مكان آخر';

  @override
  String adminTeacher(String name) {
    return 'المعلم: $name';
  }

  @override
  String get adminViewGrades => 'عرض الدرجات';

  @override
  String get adminRequestCorrection => 'إرجاع للتصحيح';

  @override
  String get adminValidate => 'اعتماد';

  @override
  String get adminCorrectionComment => 'تعليق للمعلم';

  @override
  String get adminConfirmValidate =>
      'اعتماد هذه الحصة وقفلها؟ لن يتمكن المعلم من تعديلها.';

  @override
  String get adminValidated => 'تم اعتماد الحصة';

  @override
  String get adminCorrectionSent => 'تم إرجاع الحصة للتصحيح';

  @override
  String get adminReadOnly => 'للاطلاع فقط: الإدارة لا تعدّل الدرجات.';

  @override
  String notifValidated(String date) {
    return 'تم اعتماد حصتك بتاريخ $date.';
  }

  @override
  String notifNeedsCorrection(String date) {
    return 'تم إرجاع حصة $date للتصحيح.';
  }

  @override
  String get errorNetwork =>
      'لا يوجد اتصال بالإنترنت. بياناتك محفوظة على الجهاز.';

  @override
  String get errorTimeout => 'الخادم يستغرق وقتًا طويلًا للرد. أعد المحاولة.';

  @override
  String get errorInvalidCredentials =>
      'البريد الإلكتروني أو الرمز السري غير صحيح.';

  @override
  String get errorNotAuthorized =>
      'هذا العنوان غير مسموح له. تواصل مع الإدارة.';

  @override
  String get errorAuthExpired =>
      'انتهت صلاحية جلستك. أعد تسجيل الدخول: إدخالاتك محفوظة.';

  @override
  String get errorRateLimited => 'محاولات كثيرة. أعد المحاولة بعد 15 دقيقة.';

  @override
  String get errorForbiddenGroup => 'الوصول إلى هذه المجموعة مرفوض.';

  @override
  String get errorSheetNotFound =>
      'ورقة المجموعة غير موجودة. تواصل مع الإدارة.';

  @override
  String get errorSessionNotFound => 'الحصة غير موجودة.';

  @override
  String get errorNotAClassDay => 'لا توجد دروس في هذا التاريخ.';

  @override
  String get errorBlockNotReady =>
      'الحصة غير مُهيّأة بعد في ورقة المجموعة. تواصل مع الإدارة.';

  @override
  String get errorStudentMismatch =>
      'تغيّرت قائمة التلاميذ في الورقة. أعد تحميل الحصة.';

  @override
  String get errorSheetStructure =>
      'ورقة المجموعة ذات بنية غير متوقعة. تواصل مع الإدارة.';

  @override
  String get errorValidation => 'بعض الدرجات غير صالحة. راجع الحصة.';

  @override
  String get errorConflict =>
      'تم تعديل الحصة منذ تحميلها. أعد تحميلها؛ قيمك تبقى متاحة للاطلاع.';

  @override
  String get errorLockTimeout => 'الخادم مشغول. أعد المحاولة بعد لحظات.';

  @override
  String get errorOfflineNoCopy =>
      'لم يتم تحميل هذه الحصة بعد. اتصل بالإنترنت لفتحها.';

  @override
  String get errorInternal =>
      'حدث خطأ غير متوقع. أعد المحاولة؛ وإن استمر المشكل تواصل مع الإدارة.';
}
