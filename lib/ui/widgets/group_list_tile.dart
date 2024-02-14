import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/utils/constant.dart';
import 'package:easy_contacts/view_models/groups.viewmodel.dart';
import 'package:flutter/material.dart';

class GroupListTile extends StatelessWidget {
  const GroupListTile({
    required this.group,
    required this.selected,
    super.key,
  });

  final Group group;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => _handleGroupTap(group.id),
        title: Text(group.name),
        trailing: Icon(
          Icons.check_circle_rounded,
          color: selected ? Constant.primaryColor : Colors.grey,
          size: 32,
        ),
      ),
    );
  }

  void _handleGroupTap(String groupId) {
    locator<GroupsViewModel>().toggleSelectedId(groupId);
  }
}
