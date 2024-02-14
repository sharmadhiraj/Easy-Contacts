import 'package:easy_contacts/app/hive.dart';
import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/app/route.dart';
import 'package:easy_contacts/app/theme.dart';
import 'package:easy_contacts/utils/constant.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  setupLocator();
  runApp(const EasyContactsApp());
}

class EasyContactsApp extends StatelessWidget {
  const EasyContactsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Constant.appName,
      theme: buildThemeData(),
      routerConfig: AppRouter().router,
    );
  }
}
