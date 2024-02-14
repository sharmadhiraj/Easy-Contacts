import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/utils/common.dart';
import 'package:easy_contacts/utils/toast.dart';
import 'package:easy_contacts/view_models/groups.viewmodel.dart';
import 'package:flutter/material.dart';

class GroupNameInput extends StatefulWidget {
  const GroupNameInput({
    required this.viewModel,
    super.key,
  });

  final GroupsViewModel viewModel;

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
          onSubmitted: (groupName) => _saveGroup(),
        ),
        trailing: IconButton(
          onPressed: () => _saveGroup(),
          icon: const Icon(Icons.save_outlined),
        ),
      ),
    );
  }

  void _saveGroup() {
    final String groupName = textEditingController.text.trim();
    if (groupName.isEmpty) {
      return;
    }
    if (widget.viewModel.groupAlreadyExists(groupName)) {
      ToastUtil.showError(message: "Group $groupName already exists!");
      return;
    }
    widget.viewModel.newGroup(
      Group(
        id: CommonUtil.generateRandomId(),
        name: groupName,
      ),
    );
    textEditingController.clear();
    CommonUtil.hideKeypad();
  }
}
