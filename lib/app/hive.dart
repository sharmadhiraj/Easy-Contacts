import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/utils/constant.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  Hive.registerAdapter(GroupAdapter());
  await Hive.openBox(Constant.contactsHiveBoxName);
}
