import 'package:easy_contacts/models/contact.adapter.dart';
import 'package:easy_contacts/utils/constant.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  await Hive.openBox(Constant.contactsHiveBoxName);
}
