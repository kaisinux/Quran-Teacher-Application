import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
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
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In fr, this message translates to:
  /// **'École Misk'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get navHome;

  /// No description provided for @navSessions.
  ///
  /// In fr, this message translates to:
  /// **'Mes séances'**
  String get navSessions;

  /// No description provided for @navSync.
  ///
  /// In fr, this message translates to:
  /// **'Synchronisation'**
  String get navSync;

  /// No description provided for @navSettings.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get navSettings;

  /// No description provided for @navDashboard.
  ///
  /// In fr, this message translates to:
  /// **'Tableau de bord'**
  String get navDashboard;

  /// No description provided for @logout.
  ///
  /// In fr, this message translates to:
  /// **'Déconnexion'**
  String get logout;

  /// No description provided for @loginTitle.
  ///
  /// In fr, this message translates to:
  /// **'Connexion'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Espace enseignants'**
  String get loginSubtitle;

  /// No description provided for @loginWithGoogle.
  ///
  /// In fr, this message translates to:
  /// **'Se connecter avec Google'**
  String get loginWithGoogle;

  /// No description provided for @loginOr.
  ///
  /// In fr, this message translates to:
  /// **'ou'**
  String get loginOr;

  /// No description provided for @emailLabel.
  ///
  /// In fr, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @pinLabel.
  ///
  /// In fr, this message translates to:
  /// **'PIN (5 chiffres)'**
  String get pinLabel;

  /// No description provided for @loginWithPin.
  ///
  /// In fr, this message translates to:
  /// **'Se connecter avec le PIN'**
  String get loginWithPin;

  /// No description provided for @pinInvalidFormat.
  ///
  /// In fr, this message translates to:
  /// **'Le PIN doit contenir exactement 5 chiffres.'**
  String get pinInvalidFormat;

  /// No description provided for @emailInvalid.
  ///
  /// In fr, this message translates to:
  /// **'Adresse email invalide.'**
  String get emailInvalid;

  /// No description provided for @fieldHifz.
  ///
  /// In fr, this message translates to:
  /// **'Hifz'**
  String get fieldHifz;

  /// No description provided for @fieldTajwid.
  ///
  /// In fr, this message translates to:
  /// **'Tajwid'**
  String get fieldTajwid;

  /// No description provided for @fieldDiscipline.
  ///
  /// In fr, this message translates to:
  /// **'Discipline'**
  String get fieldDiscipline;

  /// No description provided for @fieldPresence.
  ///
  /// In fr, this message translates to:
  /// **'Présence'**
  String get fieldPresence;

  /// No description provided for @fieldRemark.
  ///
  /// In fr, this message translates to:
  /// **'Remarque'**
  String get fieldRemark;

  /// No description provided for @fieldStudent.
  ///
  /// In fr, this message translates to:
  /// **'Élève'**
  String get fieldStudent;

  /// No description provided for @present.
  ///
  /// In fr, this message translates to:
  /// **'Présent'**
  String get present;

  /// No description provided for @absent.
  ///
  /// In fr, this message translates to:
  /// **'Absent'**
  String get absent;

  /// No description provided for @notEvaluated.
  ///
  /// In fr, this message translates to:
  /// **'Non évalué'**
  String get notEvaluated;

  /// No description provided for @statusDraft.
  ///
  /// In fr, this message translates to:
  /// **'Brouillon'**
  String get statusDraft;

  /// No description provided for @statusReady.
  ///
  /// In fr, this message translates to:
  /// **'Prête à envoyer'**
  String get statusReady;

  /// No description provided for @statusSent.
  ///
  /// In fr, this message translates to:
  /// **'Envoyée'**
  String get statusSent;

  /// No description provided for @statusSynced.
  ///
  /// In fr, this message translates to:
  /// **'Synchronisée'**
  String get statusSynced;

  /// No description provided for @statusNeedsCorrection.
  ///
  /// In fr, this message translates to:
  /// **'À corriger'**
  String get statusNeedsCorrection;

  /// No description provided for @statusValidated.
  ///
  /// In fr, this message translates to:
  /// **'Validée'**
  String get statusValidated;

  /// No description provided for @statusNotSent.
  ///
  /// In fr, this message translates to:
  /// **'Non envoyée'**
  String get statusNotSent;

  /// No description provided for @statusNotPrepared.
  ///
  /// In fr, this message translates to:
  /// **'Non préparée'**
  String get statusNotPrepared;

  /// No description provided for @homeGreeting.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour {name}'**
  String homeGreeting(String name);

  /// No description provided for @homeSelectedSession.
  ///
  /// In fr, this message translates to:
  /// **'Séance sélectionnée'**
  String get homeSelectedSession;

  /// No description provided for @homeNoSession.
  ///
  /// In fr, this message translates to:
  /// **'Aucune séance disponible pour le moment.'**
  String get homeNoSession;

  /// No description provided for @start.
  ///
  /// In fr, this message translates to:
  /// **'Commencer'**
  String get start;

  /// No description provided for @continueAction.
  ///
  /// In fr, this message translates to:
  /// **'Continuer'**
  String get continueAction;

  /// No description provided for @viewAction.
  ///
  /// In fr, this message translates to:
  /// **'Consulter'**
  String get viewAction;

  /// No description provided for @chooseAnotherSession.
  ///
  /// In fr, this message translates to:
  /// **'Choisir une autre séance'**
  String get chooseAnotherSession;

  /// No description provided for @sessionTitle.
  ///
  /// In fr, this message translates to:
  /// **'Séance du {date}'**
  String sessionTitle(String date);

  /// No description provided for @sessionNumber.
  ///
  /// In fr, this message translates to:
  /// **'Séance n° {number}'**
  String sessionNumber(int number);

  /// No description provided for @groupLabel.
  ///
  /// In fr, this message translates to:
  /// **'Groupe'**
  String get groupLabel;

  /// No description provided for @sessionLabel.
  ///
  /// In fr, this message translates to:
  /// **'Séance'**
  String get sessionLabel;

  /// No description provided for @savedLocally.
  ///
  /// In fr, this message translates to:
  /// **'Enregistré localement'**
  String get savedLocally;

  /// No description provided for @pendingChanges.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{Aucune modification non synchronisée} =1{1 modification non synchronisée} other{{count} modifications non synchronisées}}'**
  String pendingChanges(int count);

  /// No description provided for @pendingUploads.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{Aucun envoi en attente} =1{1 envoi en attente} other{{count} envois en attente}}'**
  String pendingUploads(int count);

  /// No description provided for @reviewSession.
  ///
  /// In fr, this message translates to:
  /// **'Vérifier la séance'**
  String get reviewSession;

  /// No description provided for @reviewTitle.
  ///
  /// In fr, this message translates to:
  /// **'Vérification avant envoi'**
  String get reviewTitle;

  /// No description provided for @send.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer'**
  String get send;

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get confirm;

  /// No description provided for @close.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get close;

  /// No description provided for @retry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get retry;

  /// No description provided for @reload.
  ///
  /// In fr, this message translates to:
  /// **'Recharger la séance'**
  String get reload;

  /// No description provided for @confirmSendTitle.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer l\'envoi'**
  String get confirmSendTitle;

  /// No description provided for @confirmSendMessage.
  ///
  /// In fr, this message translates to:
  /// **'Êtes-vous certain de vouloir envoyer les notes de cette séance ?'**
  String get confirmSendMessage;

  /// No description provided for @syncSuccess.
  ///
  /// In fr, this message translates to:
  /// **'Notes synchronisées'**
  String get syncSuccess;

  /// No description provided for @queuedOffline.
  ///
  /// In fr, this message translates to:
  /// **'Pas de connexion : l\'envoi partira dès le retour du réseau. Vos notes sont conservées.'**
  String get queuedOffline;

  /// No description provided for @summaryStudents.
  ///
  /// In fr, this message translates to:
  /// **'Élèves'**
  String get summaryStudents;

  /// No description provided for @summaryPresent.
  ///
  /// In fr, this message translates to:
  /// **'Présents'**
  String get summaryPresent;

  /// No description provided for @summaryAbsent.
  ///
  /// In fr, this message translates to:
  /// **'Absents'**
  String get summaryAbsent;

  /// No description provided for @summaryNotEvaluated.
  ///
  /// In fr, this message translates to:
  /// **'Notes non évaluées'**
  String get summaryNotEvaluated;

  /// No description provided for @summaryDisciplineRemarks.
  ///
  /// In fr, this message translates to:
  /// **'Remarques de discipline'**
  String get summaryDisciplineRemarks;

  /// No description provided for @summaryBlocking.
  ///
  /// In fr, this message translates to:
  /// **'Erreurs à corriger'**
  String get summaryBlocking;

  /// No description provided for @issueMissingRemark.
  ///
  /// In fr, this message translates to:
  /// **'Remarque obligatoire : discipline inférieure à 7.'**
  String get issueMissingRemark;

  /// No description provided for @issueInvalidGrade.
  ///
  /// In fr, this message translates to:
  /// **'Note invalide : de 0 à 10, par pas de 0,25.'**
  String get issueInvalidGrade;

  /// No description provided for @issueAbsentWithGrade.
  ///
  /// In fr, this message translates to:
  /// **'Élève absent : les notes doivent être « -- ».'**
  String get issueAbsentWithGrade;

  /// No description provided for @issueNotEvaluated.
  ///
  /// In fr, this message translates to:
  /// **'Note non évaluée.'**
  String get issueNotEvaluated;

  /// No description provided for @issueDuplicate.
  ///
  /// In fr, this message translates to:
  /// **'Élève en double.'**
  String get issueDuplicate;

  /// No description provided for @issueNoStudents.
  ///
  /// In fr, this message translates to:
  /// **'Aucun élève dans cette séance.'**
  String get issueNoStudents;

  /// No description provided for @lockedMessage.
  ///
  /// In fr, this message translates to:
  /// **'Cette séance a été validée par l\'administration et ne peut plus être modifiée.'**
  String get lockedMessage;

  /// No description provided for @pendingUploadMessage.
  ///
  /// In fr, this message translates to:
  /// **'Envoi en attente : annulez l\'envoi pour modifier la séance.'**
  String get pendingUploadMessage;

  /// No description provided for @cancelUpload.
  ///
  /// In fr, this message translates to:
  /// **'Annuler l\'envoi'**
  String get cancelUpload;

  /// No description provided for @correctionRequested.
  ///
  /// In fr, this message translates to:
  /// **'Correction demandée : {comment}'**
  String correctionRequested(String comment);

  /// No description provided for @previousStudent.
  ///
  /// In fr, this message translates to:
  /// **'Élève précédent'**
  String get previousStudent;

  /// No description provided for @nextStudent.
  ///
  /// In fr, this message translates to:
  /// **'Élève suivant'**
  String get nextStudent;

  /// No description provided for @remarkHint.
  ///
  /// In fr, this message translates to:
  /// **'Remarque libre'**
  String get remarkHint;

  /// No description provided for @remarkRequiredHint.
  ///
  /// In fr, this message translates to:
  /// **'Obligatoire : discipline inférieure à 7'**
  String get remarkRequiredHint;

  /// No description provided for @gradeInputHint.
  ///
  /// In fr, this message translates to:
  /// **'0 à 10, pas de 0,25'**
  String get gradeInputHint;

  /// No description provided for @decrease.
  ///
  /// In fr, this message translates to:
  /// **'Diminuer de 0,25'**
  String get decrease;

  /// No description provided for @increase.
  ///
  /// In fr, this message translates to:
  /// **'Augmenter de 0,25'**
  String get increase;

  /// No description provided for @sessionsEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucune séance disponible.'**
  String get sessionsEmpty;

  /// No description provided for @noClass.
  ///
  /// In fr, this message translates to:
  /// **'Pas de cours'**
  String get noClass;

  /// No description provided for @syncNow.
  ///
  /// In fr, this message translates to:
  /// **'Synchroniser maintenant'**
  String get syncNow;

  /// No description provided for @syncUpToDate.
  ///
  /// In fr, this message translates to:
  /// **'Tout est synchronisé'**
  String get syncUpToDate;

  /// No description provided for @lastSync.
  ///
  /// In fr, this message translates to:
  /// **'Dernière synchronisation : {date}'**
  String lastSync(String date);

  /// No description provided for @neverSynced.
  ///
  /// In fr, this message translates to:
  /// **'Jamais synchronisée'**
  String get neverSynced;

  /// No description provided for @settingsLanguage.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get settingsLanguage;

  /// No description provided for @languageFrench.
  ///
  /// In fr, this message translates to:
  /// **'Français'**
  String get languageFrench;

  /// No description provided for @languageArabic.
  ///
  /// In fr, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @settingsSimulateOffline.
  ///
  /// In fr, this message translates to:
  /// **'Simuler l\'absence de réseau (démo)'**
  String get settingsSimulateOffline;

  /// No description provided for @settingsAccount.
  ///
  /// In fr, this message translates to:
  /// **'Compte'**
  String get settingsAccount;

  /// No description provided for @logoutPendingMessage.
  ///
  /// In fr, this message translates to:
  /// **'Des envois sont en attente. Se déconnecter supprimerait ces notes de l\'appareil.'**
  String get logoutPendingMessage;

  /// No description provided for @logoutAnyway.
  ///
  /// In fr, this message translates to:
  /// **'Se déconnecter quand même'**
  String get logoutAnyway;

  /// No description provided for @conflictTitle.
  ///
  /// In fr, this message translates to:
  /// **'Séance modifiée ailleurs'**
  String get conflictTitle;

  /// No description provided for @adminTeacher.
  ///
  /// In fr, this message translates to:
  /// **'Enseignant : {name}'**
  String adminTeacher(String name);

  /// No description provided for @adminViewGrades.
  ///
  /// In fr, this message translates to:
  /// **'Voir les notes'**
  String get adminViewGrades;

  /// No description provided for @adminRequestCorrection.
  ///
  /// In fr, this message translates to:
  /// **'Renvoyer à corriger'**
  String get adminRequestCorrection;

  /// No description provided for @adminValidate.
  ///
  /// In fr, this message translates to:
  /// **'Valider'**
  String get adminValidate;

  /// No description provided for @adminCorrectionComment.
  ///
  /// In fr, this message translates to:
  /// **'Commentaire pour l\'enseignant'**
  String get adminCorrectionComment;

  /// No description provided for @adminConfirmValidate.
  ///
  /// In fr, this message translates to:
  /// **'Valider et verrouiller cette séance ? L\'enseignant ne pourra plus la modifier.'**
  String get adminConfirmValidate;

  /// No description provided for @adminValidated.
  ///
  /// In fr, this message translates to:
  /// **'Séance validée'**
  String get adminValidated;

  /// No description provided for @adminCorrectionSent.
  ///
  /// In fr, this message translates to:
  /// **'Séance renvoyée en correction'**
  String get adminCorrectionSent;

  /// No description provided for @adminReadOnly.
  ///
  /// In fr, this message translates to:
  /// **'Lecture seule : l\'administration ne modifie pas les notes.'**
  String get adminReadOnly;

  /// No description provided for @notifValidated.
  ///
  /// In fr, this message translates to:
  /// **'Votre séance du {date} a été validée.'**
  String notifValidated(String date);

  /// No description provided for @notifNeedsCorrection.
  ///
  /// In fr, this message translates to:
  /// **'La séance du {date} a été renvoyée pour correction.'**
  String notifNeedsCorrection(String date);

  /// No description provided for @errorNetwork.
  ///
  /// In fr, this message translates to:
  /// **'Pas de connexion Internet. Vos données sont conservées sur l\'appareil.'**
  String get errorNetwork;

  /// No description provided for @errorTimeout.
  ///
  /// In fr, this message translates to:
  /// **'Le serveur met trop de temps à répondre. Réessayez.'**
  String get errorTimeout;

  /// No description provided for @errorInvalidCredentials.
  ///
  /// In fr, this message translates to:
  /// **'Email ou PIN incorrect.'**
  String get errorInvalidCredentials;

  /// No description provided for @errorNotAuthorized.
  ///
  /// In fr, this message translates to:
  /// **'Cette adresse n\'est pas autorisée. Contactez l\'administration.'**
  String get errorNotAuthorized;

  /// No description provided for @errorAuthExpired.
  ///
  /// In fr, this message translates to:
  /// **'Votre session a expiré. Reconnectez-vous : vos saisies sont conservées.'**
  String get errorAuthExpired;

  /// No description provided for @errorRateLimited.
  ///
  /// In fr, this message translates to:
  /// **'Trop de tentatives. Réessayez dans 15 minutes.'**
  String get errorRateLimited;

  /// No description provided for @errorForbiddenGroup.
  ///
  /// In fr, this message translates to:
  /// **'Accès refusé à ce groupe.'**
  String get errorForbiddenGroup;

  /// No description provided for @errorSheetNotFound.
  ///
  /// In fr, this message translates to:
  /// **'La feuille du groupe est introuvable. Contactez l\'administration.'**
  String get errorSheetNotFound;

  /// No description provided for @errorSessionNotFound.
  ///
  /// In fr, this message translates to:
  /// **'Séance introuvable.'**
  String get errorSessionNotFound;

  /// No description provided for @errorNotAClassDay.
  ///
  /// In fr, this message translates to:
  /// **'Pas de cours à cette date.'**
  String get errorNotAClassDay;

  /// No description provided for @errorBlockNotReady.
  ///
  /// In fr, this message translates to:
  /// **'La séance n\'est pas encore préparée dans la feuille du groupe. Contactez l\'administration.'**
  String get errorBlockNotReady;

  /// No description provided for @errorStudentMismatch.
  ///
  /// In fr, this message translates to:
  /// **'La liste des élèves a changé dans la feuille. Rechargez la séance.'**
  String get errorStudentMismatch;

  /// No description provided for @errorSheetStructure.
  ///
  /// In fr, this message translates to:
  /// **'La feuille du groupe a une structure inattendue. Contactez l\'administration.'**
  String get errorSheetStructure;

  /// No description provided for @errorValidation.
  ///
  /// In fr, this message translates to:
  /// **'Certaines notes sont invalides. Vérifiez la séance.'**
  String get errorValidation;

  /// No description provided for @errorConflict.
  ///
  /// In fr, this message translates to:
  /// **'La séance a été modifiée depuis votre téléchargement. Rechargez-la ; vos valeurs restent consultables.'**
  String get errorConflict;

  /// No description provided for @errorLockTimeout.
  ///
  /// In fr, this message translates to:
  /// **'Le serveur est occupé. Réessayez dans un instant.'**
  String get errorLockTimeout;

  /// No description provided for @errorOfflineNoCopy.
  ///
  /// In fr, this message translates to:
  /// **'Cette séance n\'a pas encore été téléchargée. Connectez-vous à Internet pour l\'ouvrir.'**
  String get errorOfflineNoCopy;

  /// No description provided for @errorInternal.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur inattendue s\'est produite. Réessayez ; si le problème persiste, contactez l\'administration.'**
  String get errorInternal;
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
      <String>['ar', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
