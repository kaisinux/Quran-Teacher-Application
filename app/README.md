# misk_teacher — application Flutter

Saisie des notes des enseignants de l'École Misk : hors ligne d'abord, synchronisée
avec les Google Sheets existants via une API Google Apps Script.
L'architecture est décrite dans [`../docs/PHASE_1_ARCHITECTURE.md`](../docs/PHASE_1_ARCHITECTURE.md).

## État : Phase 2 (squelette avec données simulées)

Le serveur est **simulé en mémoire** (`lib/core/api/mock_api_client.dart`), avec les
mêmes règles que le futur backend : groupe déduit du compte, séance verrouillée,
conflits de version, idempotence, validation des notes. Toutes les données sont fictives.

Comptes de démonstration :

| Rôle | Email | PIN |
|---|---|---|
| Enseignant (groupe « Hadid 1 ») | `teacher@example.com` | `12345` |
| Administration | `admin@example.com` | `54321` |

Le bouton Google connecte l'enseignant de démo. La séance du **2026-09-27** contient
les 5 cas de référence (présent complet, absent, non évalué, discipline < 7 avec
remarque, discipline < 7 **sans** remarque, ce qui bloque l'envoi).
« Paramètres → Simuler l'absence de réseau » permet de tester le hors ligne.

## Commandes

```bash
flutter pub get
dart run build_runner build   # après modification des tables drift
flutter gen-l10n              # après modification des fichiers .arb
flutter analyze
flutter test
flutter run
```

Les fichiers générés (`*.g.dart`, `lib/l10n/gen/`) sont versionnés.

## Structure

```
lib/
  core/       api (client + mock), auth, database (drift), errors, localization,
              router, sync (outbox), theme, ui (widgets partagés), utils
  features/
    auth/       domaine utilisateur + écran de connexion
    dashboard/  navigation enseignant + accueil
    sessions/   calendrier, choix de la séance
    grades/     règles (GradeValidator), saisie téléphone/tablette, vérification
    sync/       écran de synchronisation
    admin/      tableau de bord, validation / renvoi en correction
    settings/   langue, déconnexion
  l10n/       app_fr.arb, app_ar.arb (FR par défaut, AR en RTL)
test/
  domain/     notes, absence, remarque, sélection de séance, JSON, statuts
  data/       flux complet : envoi, conflit 409, hors ligne, verrouillage, autorisations
  widget/     parcours enseignant/admin, RTL, tablette
```

## Packages

| Package | Rôle |
|---|---|
| `flutter_riverpod` | état + injection de dépendances (mocks en test) |
| `go_router` | navigation + redirections selon l'authentification et le rôle |
| `drift` + `drift_flutter` | SQLite typé : brouillons, snapshots, outbox, transactions |
| `intl` + `flutter_localizations` | FR/AR, dates, RTL |
| `uuid` | ids locaux, clés d'idempotence |

Ajoutés en Phase 4 : `dio`, `google_sign_in`, `flutter_secure_storage`, `connectivity_plus`.
