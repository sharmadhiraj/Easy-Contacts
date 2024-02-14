import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/utils/constant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

class GroupsService with ListenableServiceMixin {
  final _groups = ReactiveValue<List<Group>>(
    Hive.box(Constant.contactsHiveBoxName).get(
      Constant.groupsHiveKeyName,
      defaultValue: [],
    ).cast<Group>(),
  );

  List<Group> get groups => _groups.value;

  GroupsService() {
    listenToReactiveValues([_groups]);
  }

  void _saveToHive() => Hive.box(Constant.contactsHiveBoxName)
      .put(Constant.groupsHiveKeyName, _groups.value);

  void newGroup(Group group) {
    _groups.value.add(group);
    _saveToHive();
    notifyListeners();
  }

  List<Group> getGroupByIds(List<String> ids) {
    final List<Group> selectedGroups =
        _groups.value.where((group) => ids.contains(group.id)).toList();
    selectedGroups.sort((a, b) => a.name.compareTo(b.name));
    return selectedGroups;
  }
}
