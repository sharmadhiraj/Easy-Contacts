import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/utils/common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "CommonUtil",
    () {
      test(
        "formatGroupNames",
        () {
          final groups = [
            Group(id: "1", name: "Group 1"),
            Group(id: "2", name: "Group 2"),
            Group(id: "3", name: "Group 3"),
          ];
          const String expectedString = "Group 1, Group 2, Group 3";
          expect(CommonUtil.formatGroupNames(groups), expectedString);
        },
      );
    },
  );
}
