import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/contact.adapter.dart';
import 'package:easy_contacts/screens/home.dart';
import 'package:easy_contacts/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();
  setupLocator();
  runApp(const EasyContactsApp());
}

class EasyContactsApp extends StatelessWidget {
  const EasyContactsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constant.appName,
      theme: _buildThemeData(),
      home: const HomeScreen(),
    );
  }
}

ThemeData _buildThemeData() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Constant.primaryColor,
    ),
    useMaterial3: false,
  );
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  await Hive.openBox(Constant.contactsHiveBoxName);
}
