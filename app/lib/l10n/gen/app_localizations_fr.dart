// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'École Misk';

  @override
  String get navHome => 'Accueil';

  @override
  String get navSessions => 'Mes séances';

  @override
  String get navSync => 'Synchronisation';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get navDashboard => 'Tableau de bord';

  @override
  String get logout => 'Déconnexion';

  @override
  String get loginTitle => 'Connexion';

  @override
  String get loginSubtitle => 'Espace enseignants';

  @override
  String get loginWithGoogle => 'Se connecter avec Google';

  @override
  String get loginOr => 'ou';

  @override
  String get emailLabel => 'Email';

  @override
  String get pinLabel => 'PIN (5 chiffres)';

  @override
  String get loginWithPin => 'Se connecter avec le PIN';

  @override
  String get pinInvalidFormat => 'Le PIN doit contenir exactement 5 chiffres.';

  @override
  String get emailInvalid => 'Adresse email invalide.';

  @override
  String get fieldHifz => 'Hifz';

  @override
  String get fieldTajwid => 'Tajwid';

  @override
  String get fieldDiscipline => 'Discipline';

  @override
  String get fieldPresence => 'Présence';

  @override
  String get fieldRemark => 'Remarque';

  @override
  String get fieldStudent => 'Élève';

  @override
  String get present => 'Présent';

  @override
  String get absent => 'Absent';

  @override
  String get notEvaluated => 'Non évalué';

  @override
  String get statusDraft => 'Brouillon';

  @override
  String get statusReady => 'Prête à envoyer';

  @override
  String get statusSent => 'Envoyée';

  @override
  String get statusSynced => 'Synchronisée';

  @override
  String get statusNeedsCorrection => 'À corriger';

  @override
  String get statusValidated => 'Validée';

  @override
  String get statusNotSent => 'Non envoyée';

  @override
  String get statusNotPrepared => 'Non préparée';

  @override
  String homeGreeting(String name) {
    return 'Bonjour $name';
  }

  @override
  String get homeSelectedSession => 'Séance sélectionnée';

  @override
  String get homeNoSession => 'Aucune séance disponible pour le moment.';

  @override
  String get start => 'Commencer';

  @override
  String get continueAction => 'Continuer';

  @override
  String get viewAction => 'Consulter';

  @override
  String get chooseAnotherSession => 'Choisir une autre séance';

  @override
  String sessionTitle(String date) {
    return 'Séance du $date';
  }

  @override
  String sessionNumber(int number) {
    return 'Séance n° $number';
  }

  @override
  String get groupLabel => 'Groupe';

  @override
  String get sessionLabel => 'Séance';

  @override
  String get savedLocally => 'Enregistré localement';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count modifications non synchronisées',
      one: '1 modification non synchronisée',
      zero: 'Aucune modification non synchronisée',
    );
    return '$_temp0';
  }

  @override
  String pendingUploads(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count envois en attente',
      one: '1 envoi en attente',
      zero: 'Aucun envoi en attente',
    );
    return '$_temp0';
  }

  @override
  String get reviewSession => 'Vérifier la séance';

  @override
  String get reviewTitle => 'Vérification avant envoi';

  @override
  String get send => 'Envoyer';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get close => 'Fermer';

  @override
  String get retry => 'Réessayer';

  @override
  String get reload => 'Recharger la séance';

  @override
  String get confirmSendTitle => 'Confirmer l\'envoi';

  @override
  String get confirmSendMessage =>
      'Êtes-vous certain de vouloir envoyer les notes de cette séance ?';

  @override
  String get syncSuccess => 'Notes synchronisées';

  @override
  String get queuedOffline =>
      'Pas de connexion : l\'envoi partira dès le retour du réseau. Vos notes sont conservées.';

  @override
  String get summaryStudents => 'Élèves';

  @override
  String get summaryPresent => 'Présents';

  @override
  String get summaryAbsent => 'Absents';

  @override
  String get summaryNotEvaluated => 'Notes non évaluées';

  @override
  String get summaryDisciplineRemarks => 'Remarques de discipline';

  @override
  String get summaryBlocking => 'Erreurs à corriger';

  @override
  String get issueMissingRemark =>
      'Remarque obligatoire : discipline inférieure à 7.';

  @override
  String get issueInvalidGrade => 'Note invalide : de 0 à 10, par pas de 0,25.';

  @override
  String get issueAbsentWithGrade =>
      'Élève absent : les notes doivent être « -- ».';

  @override
  String get issueNotEvaluated => 'Note non évaluée.';

  @override
  String get issueDuplicate => 'Élève en double.';

  @override
  String get issueNoStudents => 'Aucun élève dans cette séance.';

  @override
  String get lockedMessage =>
      'Cette séance a été validée par l\'administration et ne peut plus être modifiée.';

  @override
  String get pendingUploadMessage =>
      'Envoi en attente : annulez l\'envoi pour modifier la séance.';

  @override
  String get cancelUpload => 'Annuler l\'envoi';

  @override
  String correctionRequested(String comment) {
    return 'Correction demandée : $comment';
  }

  @override
  String get previousStudent => 'Élève précédent';

  @override
  String get nextStudent => 'Élève suivant';

  @override
  String get remarkHint => 'Remarque libre';

  @override
  String get remarkRequiredHint => 'Obligatoire : discipline inférieure à 7';

  @override
  String get gradeInputHint => '0 à 10, pas de 0,25';

  @override
  String get decrease => 'Diminuer de 0,25';

  @override
  String get increase => 'Augmenter de 0,25';

  @override
  String get sessionsEmpty => 'Aucune séance disponible.';

  @override
  String get noClass => 'Pas de cours';

  @override
  String get syncNow => 'Synchroniser maintenant';

  @override
  String get syncUpToDate => 'Tout est synchronisé';

  @override
  String lastSync(String date) {
    return 'Dernière synchronisation : $date';
  }

  @override
  String get neverSynced => 'Jamais synchronisée';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageArabic => 'العربية';

  @override
  String get settingsSimulateOffline => 'Simuler l\'absence de réseau (démo)';

  @override
  String get settingsAccount => 'Compte';

  @override
  String get logoutPendingMessage =>
      'Des envois sont en attente. Se déconnecter supprimerait ces notes de l\'appareil.';

  @override
  String get logoutAnyway => 'Se déconnecter quand même';

  @override
  String get conflictTitle => 'Séance modifiée ailleurs';

  @override
  String adminTeacher(String name) {
    return 'Enseignant : $name';
  }

  @override
  String get adminViewGrades => 'Voir les notes';

  @override
  String get adminRequestCorrection => 'Renvoyer à corriger';

  @override
  String get adminValidate => 'Valider';

  @override
  String get adminCorrectionComment => 'Commentaire pour l\'enseignant';

  @override
  String get adminConfirmValidate =>
      'Valider et verrouiller cette séance ? L\'enseignant ne pourra plus la modifier.';

  @override
  String get adminValidated => 'Séance validée';

  @override
  String get adminCorrectionSent => 'Séance renvoyée en correction';

  @override
  String get adminReadOnly =>
      'Lecture seule : l\'administration ne modifie pas les notes.';

  @override
  String notifValidated(String date) {
    return 'Votre séance du $date a été validée.';
  }

  @override
  String notifNeedsCorrection(String date) {
    return 'La séance du $date a été renvoyée pour correction.';
  }

  @override
  String get errorNetwork =>
      'Pas de connexion Internet. Vos données sont conservées sur l\'appareil.';

  @override
  String get errorTimeout =>
      'Le serveur met trop de temps à répondre. Réessayez.';

  @override
  String get errorInvalidCredentials => 'Email ou PIN incorrect.';

  @override
  String get errorNotAuthorized =>
      'Cette adresse n\'est pas autorisée. Contactez l\'administration.';

  @override
  String get errorAuthExpired =>
      'Votre session a expiré. Reconnectez-vous : vos saisies sont conservées.';

  @override
  String get errorRateLimited =>
      'Trop de tentatives. Réessayez dans 15 minutes.';

  @override
  String get errorForbiddenGroup => 'Accès refusé à ce groupe.';

  @override
  String get errorSheetNotFound =>
      'La feuille du groupe est introuvable. Contactez l\'administration.';

  @override
  String get errorSessionNotFound => 'Séance introuvable.';

  @override
  String get errorNotAClassDay => 'Pas de cours à cette date.';

  @override
  String get errorBlockNotReady =>
      'La séance n\'est pas encore préparée dans la feuille du groupe. Contactez l\'administration.';

  @override
  String get errorStudentMismatch =>
      'La liste des élèves a changé dans la feuille. Rechargez la séance.';

  @override
  String get errorSheetStructure =>
      'La feuille du groupe a une structure inattendue. Contactez l\'administration.';

  @override
  String get errorValidation =>
      'Certaines notes sont invalides. Vérifiez la séance.';

  @override
  String get errorConflict =>
      'La séance a été modifiée depuis votre téléchargement. Rechargez-la ; vos valeurs restent consultables.';

  @override
  String get errorLockTimeout =>
      'Le serveur est occupé. Réessayez dans un instant.';

  @override
  String get errorOfflineNoCopy =>
      'Cette séance n\'a pas encore été téléchargée. Connectez-vous à Internet pour l\'ouvrir.';

  @override
  String get errorInternal =>
      'Une erreur inattendue s\'est produite. Réessayez ; si le problème persiste, contactez l\'administration.';
}
