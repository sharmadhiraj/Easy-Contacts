import 'package:easy_contacts/models/contact.dart';

class ValidationUtils {
  static String? validateFirstName(String? name) {
    return _isBlank(name) ? "Please provide first name" : null;
  }

  static String? validatePhoneNumber(String? phoneNo) {
    return _isBlank(phoneNo) ? "Please provide phone number" : null;
  }

  static bool isValidContact(Contact contact) {
    return validateFirstName(contact.firstName) == null &&
        validatePhoneNumber(contact.phoneNo) == null;
  }

  static bool _isBlank(String? value) => value == null || value.trim().isEmpty;
}
