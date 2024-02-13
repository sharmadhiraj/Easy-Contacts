import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/util/constant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

class ContactsService with ListenableServiceMixin {
  final _contacts = ReactiveValue<List<Contact>>(
    Hive.box(Constant.contactsHiveBoxName).get(
      Constant.contactsHiveKeyName,
      defaultValue: [],
    ).cast<Contact>(),
  );

  List<Contact> get contacts => _contacts.value;

  ContactsService() {
    listenToReactiveValues([_contacts]);
  }

  void _saveToHive() => Hive.box(Constant.contactsHiveBoxName)
      .put(Constant.contactsHiveKeyName, _contacts.value);

  void newContact(Contact contact) {
    _contacts.value.insert(0, contact);
    _saveToHive();
    notifyListeners();
  }

  bool removeContact(String id) {
    final int index = _contacts.value.indexWhere((contact) => contact.id == id);
    if (index != -1) {
      _contacts.value.removeAt(index);
      _saveToHive();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool updateContact(Contact updatedContact) {
    final int index = _contacts.value
        .indexWhere((contact) => contact.id == updatedContact.id);
    if (index != -1) {
      _contacts.value[index] = updatedContact;
      _saveToHive();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
