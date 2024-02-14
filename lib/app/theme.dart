import 'package:easy_contacts/utils/constant.dart';
import 'package:flutter/material.dart';

ThemeData buildThemeData() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Constant.primaryColor,
      primary: Constant.primaryColor,
    ),
    useMaterial3: false,
  );
}
