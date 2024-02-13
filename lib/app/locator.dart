import 'package:easy_contacts/services/contacts.service.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => ContactsService());
}
