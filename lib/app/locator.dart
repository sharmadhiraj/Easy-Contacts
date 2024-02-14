import 'package:easy_contacts/services/contacts.service.dart';
import 'package:easy_contacts/services/groups.service.dart';
import 'package:easy_contacts/view_models/contacts.viewmodel.dart';
import 'package:easy_contacts/view_models/groups.viewmodel.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ContactsService());
  locator.registerLazySingleton(() => ContactsViewModel());
  locator.registerLazySingleton(() => GroupsService());
  locator.registerLazySingleton(() => GroupsViewModel());
}
