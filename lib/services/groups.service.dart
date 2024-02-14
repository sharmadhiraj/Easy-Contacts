import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/services/base.service.dart';
import 'package:easy_contacts/utils/constant.dart';

class GroupsService extends BaseService<Group> {
  GroupsService() : super();

  List<Group> getGroupByIds(List<String> ids) {
    final List<Group> selectedGroups =
        items.where((group) => ids.contains(group.id)).toList();
    selectedGroups.sort((a, b) => a.name.compareTo(b.name));
    return selectedGroups;
  }

  @override
  String getHiveKeyName() => Constant.groupsHiveKeyName;
}
