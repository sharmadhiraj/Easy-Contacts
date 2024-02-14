import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/utils/common.dart';
import 'package:easy_contacts/utils/toast.dart';
import 'package:easy_contacts/view_models/groups.viewmodel.dart';
import 'package:flutter/material.dart';

class GroupNameInput extends StatefulWidget {
  const GroupNameInput({super.key});

  @override
  State<GroupNameInput> createState() => _GroupNameInputState();
}

class _GroupNameInputState extends State<GroupNameInput> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        title: TextField(
          controller: textEditingController,
          decoration: const InputDecoration(labelText: "Create new group"),
          onSubmitted: (groupName) =>
              _saveGroup(context, textEditingController),
        ),
        trailing: IconButton(
          onPressed: () => _saveGroup(context, textEditingController),
          icon: const Icon(Icons.done),
        ),
      ),
    );
  }

  void _saveGroup(
    BuildContext context,
    TextEditingController textEditingController,
  ) {
    final String groupName = textEditingController.text.trim();
    if (groupName.isEmpty) {
      return;
    }
    final GroupsViewModel model = locator<GroupsViewModel>();
    if (model.groupAlreadyExists(groupName)) {
      ToastUtil.showError(message: "Group $groupName already exists!");
      return;
    }
    model.newGroup(
      Group(
        id: CommonUtil.generateRandomId(),
        name: groupName,
      ),
    );
    textEditingController.clear();
    CommonUtil.hideKeypad();
  }
}
