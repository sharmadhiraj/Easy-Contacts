import 'package:easy_contacts/ui/screens/contact_detail.dart';
import 'package:easy_contacts/ui/screens/contacts.dart';
import 'package:easy_contacts/ui/screens/groups.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: AppRoute.contacts.path,
    routes: [
      GoRoute(
        name: AppRoute.contacts.name,
        path: AppRoute.contacts.path,
        builder: (context, state) => const ContactsScreen(),
      ),
      GoRoute(
        name: AppRoute.contactDetail.name,
        path: AppRoute.contactDetail.path,
        builder: (context, state) => ContactDetailScreen(
          id: state.extra as String,
        ),
      ),
      GoRoute(
        name: AppRoute.groups.name,
        path: AppRoute.groups.path,
        builder: (context, state) => GroupsScreen(
          selectedIds: state.extra as List<String>,
        ),
      ),
    ],
  );

  GoRouter get router => _router;
}

enum AppRoute {
  contacts(
    name: "contacts",
    path: "/",
  ),
  contactDetail(
    name: "contact_detail",
    path: "/contact_detail",
  ),
  groups(
    name: "groups",
    path: "/groups",
  );

  const AppRoute({required this.name, required this.path});

  final String name;
  final String path;
}
