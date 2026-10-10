import 'dart:io';

import 'package:easy_contacts/app/hive.dart';
import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/models/group.dart';
import 'package:hive_flutter/hive_flutter.dart';

Contact buildContact(String firstName, {String lastName = "", String? id}) {
  return Contact.empty()
    ..id = id ?? firstName
    ..firstName = firstName
    ..lastName = lastName
    ..phoneNo = "0400 000 000";
}

Future<Directory> setUpTestStorage() async {
  final Directory dir = await Directory.systemTemp.createTemp("easy_contacts");
  Hive.init(dir.path);
  await locator.reset();
  if (!Hive.isAdapterRegistered(ContactAdapter().typeId)) {
    Hive
      ..registerAdapter(ContactAdapter())
      ..registerAdapter(GroupAdapter());
  }
  await openHiveBoxes();
  setupLocator();
  return dir;
}

Future<void> tearDownTestStorage(Directory dir) async {
  await locator.reset();
  await Hive.deleteFromDisk();
  await Hive.close();
  await dir.delete(recursive: true);
}
