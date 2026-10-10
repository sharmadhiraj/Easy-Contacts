import 'package:easy_contacts/utils/validation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_setup.dart';

void main() {
  group("ValidationUtils", () {
    test("blank names and phone numbers are rejected", () {
      expect(ValidationUtils.validateFirstName("  "), isNotNull);
      expect(ValidationUtils.validateFirstName(null), isNotNull);
      expect(ValidationUtils.validatePhoneNumber(""), isNotNull);
    });

    test("non-blank values are accepted", () {
      expect(ValidationUtils.validateFirstName("Ada"), isNull);
      expect(ValidationUtils.validatePhoneNumber("123"), isNull);
    });

    test("isValidContact requires first name and phone number", () {
      expect(ValidationUtils.isValidContact(buildContact("Ada")), isTrue);
      expect(
        ValidationUtils.isValidContact(buildContact("Ada")..phoneNo = ""),
        isFalse,
      );
      expect(ValidationUtils.isValidContact(buildContact("")), isFalse);
    });
  });
}
