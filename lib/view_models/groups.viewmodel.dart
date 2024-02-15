import 'package:collection/collection.dart';
import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/services/groups.service.dart';
import 'package:stacked/stacked.dart';

class GroupsViewModel extends ReactiveViewModel {
  final GroupsService _groupsService = locator<GroupsService>();

  final List<String> selectedIds;

  GroupsViewModel({required this.selectedIds});

  void toggleSelectedGroupId(String groupId) {
    if (selectedIds.contains(groupId)) {
      selectedIds.remove(groupId);
    } else {
      selectedIds.add(groupId);
    }
    notifyListeners();
  }

  bool isSelectedGroup(Group group) {
    return selectedIds.contains(group.id);
  }

  bool groupAlreadyExists(String groupName) {
    return _groupsService.items
            .firstWhereOrNull((group) => group.name == groupName) !=
        null;
  }

  List<Group> getSelectedGroups() {
    return _groupsService.getGroupByIds(selectedIds);
  }

  List<Group> getGroups() {
    final List<Group> groups = _groupsService.items;
    groups.sort((a, b) => a.name.compareTo(b.name));
    return groups;
  }

  bool hasGroups() {
    return _groupsService.items.isNotEmpty;
  }

  void newGroup(Group group) {
    _groupsService.addItem(group);
    toggleSelectedGroupId(group.id);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_groupsService];
}
