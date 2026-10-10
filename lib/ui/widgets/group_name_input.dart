import 'package:easy_contacts/utils/common.dart';
import 'package:flutter/material.dart';

class GroupNameInput extends StatefulWidget {
  const GroupNameInput({
    required this.onSaveGroup,
    super.key,
  });

  final bool Function(String name) onSaveGroup;

  @override
  State<GroupNameInput> createState() => _GroupNameInputState();
}

class _GroupNameInputState extends State<GroupNameInput> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: SafeArea(child: _buildTile()),
      ),
    );
  }

  Widget _buildTile() {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      title: TextField(
        controller: textEditingController,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(labelText: "Create new group"),
        onSubmitted: (groupName) => _saveGroup(),
      ),
      trailing: IconButton.filled(
        tooltip: "Add group",
        onPressed: _saveGroup,
        icon: const Icon(Icons.add),
      ),
    );
  }

  void _saveGroup() {
    final String groupName = textEditingController.text.trim();
    if (groupName.isEmpty) {
      return;
    }
    final bool saved = widget.onSaveGroup(groupName);
    if (saved) {
      textEditingController.clear();
      CommonUtil.hideKeypad();
    }
  }
}
