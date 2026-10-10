import 'dart:io';

import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/app/theme.dart';
import 'package:easy_contacts/ui/screens/contacts.dart';
import 'package:easy_contacts/view_models/contacts.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_setup.dart';

Widget _buildApp() {
  return MaterialApp(
    theme: buildLightTheme(),
    home: const ContactsScreen(),
  );
}

void main() {
  Future<void> withStorage(
    WidgetTester tester,
    Future<void> Function() body,
  ) async {
    final Directory dir = (await tester.runAsync(setUpTestStorage))!;
    try {
      await body();
    } finally {
      await tester.runAsync(() => tearDownTestStorage(dir));
    }
  }

  testWidgets("shows the empty state when there are no contacts",
      (tester) async {
    await withStorage(tester, () async {
      await tester.pumpWidget(_buildApp());

      expect(find.text("No contacts yet"), findsOneWidget);
      expect(find.text("New contact"), findsOneWidget);
    });
  });

  testWidgets("lists contacts and shows no results for a bad search",
      (tester) async {
    await withStorage(tester, () async {
      await tester.runAsync(() async {
        locator<ContactsViewModel>()
          ..newContact(buildContact("Alice"))
          ..newContact(buildContact("Bob"));
      });
      await tester.pumpWidget(_buildApp());

      expect(find.text("Alice"), findsOneWidget);
      expect(find.text("Bob"), findsOneWidget);

      await tester.enterText(find.byType(TextField), "zzz");
      await tester.pump();

      expect(find.text("No results"), findsOneWidget);
    });
  });
}
