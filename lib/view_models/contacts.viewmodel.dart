import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/services/contacts.service.dart';
import 'package:stacked/stacked.dart';

class ContactsViewModel extends ReactiveViewModel {
  final ContactsService _contactsService = locator<ContactsService>();

  List<Contact> getContacts() {
    final List<Contact> contacts = _contactsService.contacts;
    contacts.sort((a, b) => a.getFullName().compareTo(b.getFullName()));
    return contacts;
  }

  bool hasContacts() => _contactsService.contacts.isNotEmpty;

  void newContact(Contact contact) {
    _contactsService.newContact(contact);
  }

  bool removeContact(String id) {
    return _contactsService.removeContact(id);
  }

  bool updateContact(Contact updatedContact) {
    return _contactsService.updateContact(updatedContact);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_contactsService];
}
