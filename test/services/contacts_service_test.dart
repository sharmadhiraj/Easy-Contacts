import 'dart:io';

import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/services/contacts.service.dart';
import 'package:easy_contacts/utils/constant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../helpers/test_setup.dart';

void main() {
  late Directory dir;

  setUp(() async => dir = await setUpTestStorage());
  tearDown(() => tearDownTestStorage(dir));

  group("ContactsService", () {
    test("adds, updates and removes items", () {
      final ContactsService service = locator<ContactsService>()
        ..addItem(buildContact("Ada"));
      expect(service.items.map((c) => c.firstName), ["Ada"]);

      final bool updated = service.updateItem(
        buildContact("Ada", lastName: "Lovelace"),
      );
      expect(updated, isTrue);
      expect(service.getById("Ada")?.lastName, "Lovelace");

      expect(service.removeItem("Ada"), isTrue);
      expect(service.items, isEmpty);
    });

    test("update and remove report missing items", () {
      final ContactsService service = locator<ContactsService>();

      expect(service.updateItem(buildContact("Ghost")), isFalse);
      expect(service.removeItem("Ghost"), isFalse);
    });

    test("migrates the legacy single-list storage once", () async {
      await Hive.box(Constant.legacyBoxName)
          .put("contacts", <Contact>[buildContact("Old")]);
      await locator.reset();
      setupLocator();

      final ContactsService service = locator<ContactsService>();
      expect(service.items.map((c) => c.firstName), ["Old"]);
      expect(Hive.box(Constant.legacyBoxName).get("contacts"), isNull);
    });
  });
}
