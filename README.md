# Easy Contacts

A simple, offline contact manager built with Flutter. Add contacts, organise them into groups, and
reach them with one tap. All data stays on the device: no account, backend or Firebase setup needed.

## Demo

![Demo Gif](demo.gif)

## Features

- **Contacts:** add, edit and delete contacts (name, phone, email, nickname, relationship, note).
- **Search:** find contacts by name; the list is always sorted alphabetically.
- **Groups:** create groups, assign them to contacts, swipe to delete a group.
- **Quick actions:** call, message or email a contact, and copy their phone number.
- **Undo:** swipe a contact to delete it, with an Undo option.
- **Light and dark themes:** Material 3, follows the system setting.

## Getting started

Requires Flutter 3.27 or newer (Dart 3.6+).

```sh
flutter pub get
flutter run
```

Checks:

```sh
flutter analyze
flutter test
```

## Web deployment

Every push to `main` builds the web app and publishes it to GitHub Pages
(`.github/workflows/deploy-web.yml`). One-time setup: in the repository go to **Settings > Pages**
and set **Source** to **GitHub Actions**.

## Tech stack

| Concern                    | Package                                               |
|----------------------------|-------------------------------------------------------|
| Architecture (MVVM)        | [Stacked](https://pub.dev/packages/stacked)           |
| Local storage              | [Hive](https://pub.dev/packages/hive)                 |
| Navigation                 | [GoRouter](https://pub.dev/packages/go_router)        |
| Dependency injection       | [GetIt](https://pub.dev/packages/get_it)              |
| Launching call, SMS, email | [url_launcher](https://pub.dev/packages/url_launcher) |

## How it fits together

```
View (ui/)  ->  ViewModel (view_models/)  ->  Service (services/)  ->  Hive
```

- **Views** only render state and forward user actions.
- **ViewModels** hold UI logic (search, sorting, selection) and rebuild the view when a service
  changes.
- **Services** own the data. `BaseService<T>` stores one Hive entry per item (keyed by id) and
  exposes a reactive list, so `ContactsService` and `GroupsService` are a few lines each.
- **GetIt** (`app/locator.dart`) provides the services and the shared `ContactsViewModel`.

```
lib/
  app/          app setup: Hive init, dependency injection, routes, theme
  models/       Contact, Group and their Hive adapters
  services/     BaseService, ContactsService, GroupsService, contact actions
  view_models/  one ViewModel per screen or sheet
  ui/           screens/ and reusable widgets/
  utils/        constants, validation, toasts, helpers
test/           unit tests (services, view models, utils) and widget tests
```

### Routes

| Path           | Screen                                                  |
|----------------|---------------------------------------------------------|
| `/`            | Contacts list                                           |
| `/contact/:id` | Contact detail                                          |
| `/groups`      | Group picker (selected group ids are passed as `extra`) |

Adding or editing a contact happens in a bottom sheet, not a route.

### Storage

Contacts and groups live in their own Hive boxes (`contact_items`, `group_items`). Data saved by
older versions (one list per type in the `contacts` box) is migrated automatically on first launch.

## Roadmap

- Import from and export to the device contacts or a vCard file.
- Favourites and a recently called list.
- Localisation.
