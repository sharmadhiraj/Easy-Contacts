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
    return _groupsService.items.any(
      (group) => group.name.toLowerCase() == groupName.toLowerCase(),
    );
  }

  List<Group> getSelectedGroups() {
    return _groupsService.getGroupByIds(selectedIds);
  }

  List<Group> getGroups() {
    return _groupsService.items.toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  bool hasGroups() {
    return _groupsService.items.isNotEmpty;
  }

  void removeGroup(String id) {
    selectedIds.remove(id);
    _groupsService.removeItem(id);
    notifyListeners();
  }

  void restoreGroup(Group group) => _groupsService.addItem(group);

  void newGroup(Group group) {
    _groupsService.addItem(group);
    toggleSelectedGroupId(group.id);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_groupsService];
}
