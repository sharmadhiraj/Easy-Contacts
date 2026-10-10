import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/services/contacts.service.dart';
import 'package:stacked/stacked.dart';

class ContactsViewModel extends ReactiveViewModel {
  final ContactsService _contactsService = locator<ContactsService>();

  String _searchQuery = "";

  List<Contact> getContacts() {
    final String query = _searchQuery.trim().toLowerCase();
    return _contactsService.items
        .where((contact) => contact.getFullName().toLowerCase().contains(query))
        .toList()
      ..sort(
        (a, b) => a
            .getFullName()
            .toLowerCase()
            .compareTo(b.getFullName().toLowerCase()),
      );
  }

  void setSearchQuery(String searchQuery) {
    _searchQuery = searchQuery;
    notifyListeners();
  }

  bool hasContacts() => _contactsService.items.isNotEmpty;

  void newContact(Contact contact) {
    _contactsService.addItem(contact);
  }

  void restoreContact(Contact contact) => _contactsService.addItem(contact);

  bool removeContact(String id) {
    return _contactsService.removeItem(id);
  }

  bool updateContact(Contact updatedContact) {
    return _contactsService.updateItem(updatedContact);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_contactsService];
}
