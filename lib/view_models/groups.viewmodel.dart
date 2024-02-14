import 'package:collection/collection.dart';
import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/services/groups.service.dart';
import 'package:stacked/stacked.dart';

class GroupsViewModel extends ReactiveViewModel {
  final GroupsService _groupsService = locator<GroupsService>();

  List<String> _selectedIds = [];

  List<String> getSelectedIds() => _selectedIds;

  void setSelectedIds(List<String> selectIds) {
    _selectedIds = selectIds;
    notifyListeners();
  }

  void toggleSelectedId(String groupId) {
    if (_selectedIds.contains(groupId)) {
      _selectedIds.remove(groupId);
    } else {
      _selectedIds.add(groupId);
    }
    notifyListeners();
  }

  bool isSelectedGroup(Group group) {
    return _selectedIds.contains(group.id);
  }

  bool groupAlreadyExists(String groupName) {
    return _groupsService.groups
            .firstWhereOrNull((group) => group.name == groupName) !=
        null;
  }

  List<Group> getSelectedGroups() {
    return _groupsService.getGroupByIds(_selectedIds);
  }

  List<Group> getGroups() {
    final List<Group> groups = _groupsService.groups;
    groups.sort((a, b) => a.name.compareTo(b.name));
    return groups;
  }

  bool hasGroups() {
    return _groupsService.groups.isNotEmpty;
  }

  void newGroup(Group group) {
    _groupsService.newGroup(group);
    toggleSelectedId(group.id);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_groupsService];
}
