import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/services/base.service.dart';
import 'package:easy_contacts/utils/constant.dart';

class GroupsService extends BaseService<Group> {
  GroupsService() : super();

  List<Group> getGroupByIds(List<String> ids) {
    return items.where((group) => ids.contains(group.id)).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  @override
  String get boxName => Constant.groupsBoxName;

  @override
  String get legacyKey => "groups";
}
