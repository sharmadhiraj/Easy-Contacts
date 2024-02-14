import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/services/contacts.service.dart';
import 'package:stacked/stacked.dart';

class ContactsViewModel extends ReactiveViewModel {
  final ContactsService _contactsService = locator<ContactsService>();

  String _searchQuery = "";

  List<Contact> getContacts() {
    List<Contact> contacts = _contactsService.contacts;
    if (_searchQuery.trim().isNotEmpty) {
      contacts = contacts
          .where((contact) => contact
              .getFullName()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()))
          .toList();
    }
    contacts.sort((a, b) => a.getFullName().compareTo(b.getFullName()));
    return contacts;
  }

  void setSearchQuery(String searchQuery) {
    _searchQuery = searchQuery;
    notifyListeners();
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
