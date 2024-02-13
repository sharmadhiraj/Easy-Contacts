import 'package:easy_contacts/screens/home.dart';
import 'package:easy_contacts/util/constant.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EasyContactsApp());
}

class EasyContactsApp extends StatelessWidget {
  const EasyContactsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constant.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Constant.primaryColor),
        useMaterial3: false,
      ),
      home: const HomeScreen(),
    );
  }
}
