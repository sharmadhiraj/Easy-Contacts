import 'dart:io';

import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/view_models/contacts.viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_setup.dart';

void main() {
  late Directory dir;
  late ContactsViewModel viewModel;

  setUp(() async {
    dir = await setUpTestStorage();
    viewModel = locator<ContactsViewModel>()
      ..newContact(buildContact("bob", lastName: "Stone"))
      ..newContact(buildContact("Alice", lastName: "Smith"))
      ..newContact(buildContact("Carl"));
  });
  tearDown(() => tearDownTestStorage(dir));

  group("ContactsViewModel", () {
    test("sorts contacts by name ignoring case", () {
      expect(
        viewModel.getContacts().map((c) => c.firstName),
        ["Alice", "bob", "Carl"],
      );
    });

    test("filters contacts by search query ignoring case", () {
      viewModel.setSearchQuery("ST");
      expect(viewModel.getContacts().map((c) => c.firstName), ["bob"]);
    });

    test("restores a removed contact", () {
      final Contact removed = viewModel.getContacts().first;
      viewModel.removeContact(removed.id);
      expect(viewModel.getContacts(), hasLength(2));

      viewModel.restoreContact(removed);
      expect(viewModel.getContacts(), hasLength(3));
    });
  });
}
