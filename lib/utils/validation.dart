import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/utils/toast.dart';

class ValidationUtils {
  static bool validateContact(Contact contact) {
    if (!_isValidName(contact.firstName)) {
      _showValidationError("Please provide first name!");
      return false;
    } else if (!_isValidPhoneNumber(contact.phoneNo)) {
      _showValidationError("Please provide phone number!");
      return false;
    }
    return true;
  }

  static bool _isValidName(String name) => name.trim().isNotEmpty;

  static bool _isValidPhoneNumber(String phoneNo) => phoneNo.trim().isNotEmpty;

  static void _showValidationError(String message) {
    ToastUtil.showError(message: message);
  }
}
