import 'package:easy_contacts/models/group.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class CommonUtil {
  static const Uuid _uuid = Uuid();

  static String generateRandomId() {
    return _uuid.v4();
  }

  static void launchPhoneNumber(String phoneNumber) async {
    try {
      final Uri uri = Uri.parse("tel:$phoneNumber");
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
