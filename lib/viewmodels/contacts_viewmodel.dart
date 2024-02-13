import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/services/contacts.service.dart';
import 'package:stacked/stacked.dart';

class ContactScreenViewModel extends BaseViewModel with ListenableServiceMixin {
  final ContactsService _contactsService = locator<ContactsService>();

  List<Contact> get contacts => _contactsService.contacts;

  late final newContact = _contactsService.newContact;
  late final removeContact = _contactsService.removeContact;
  late final updateContact = _contactsService.updateContact;
}
