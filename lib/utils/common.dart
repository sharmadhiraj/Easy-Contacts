import 'package:easy_contacts/models/group.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class CommonUtil {
  static const Uuid _uuid = Uuid();

  static String generateRandomId() {
    return _uuid.v4();
  }

  static Future<void> launchPhoneNumber(String phoneNumber) =>
      _launch(Uri(scheme: "tel", path: phoneNumber));

  static Future<void> launchSms(String phoneNumber) =>
      _launch(Uri(scheme: "sms", path: phoneNumber));

  static Future<void> launchEmail(String email) =>
      _launch(Uri(scheme: "mailto", path: email));

  static Future<void> _launch(Uri uri) async {
    try {
      await launchUrl(uri);
    } catch (e) {
      debugPrint("Exception while launching url: $e");
    }
  }

  static void hideKeypad() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String formatGroupNames(List<Group> groups) {
    return groups.map((e) => e.name).join(", ");
  }
}
