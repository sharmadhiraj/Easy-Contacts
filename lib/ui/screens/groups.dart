import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/ui/widgets/empty_list_label.dart';
import 'package:easy_contacts/utils/common.dart';
import 'package:easy_contacts/utils/constant.dart';
import 'package:easy_contacts/utils/toast.dart';
import 'package:easy_contacts/view_models/groups.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({Key? key}) : super(key: key);

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomSheet: _bottomSheet(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Groups"),
      actions: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.done),
        )
      ],
    );
  }

  Widget _buildBody() {
    return ViewModelBuilder<GroupsViewModel>.reactive(
      viewModelBuilder: () => locator<GroupsViewModel>(),
      disposeViewModel: false,
      builder: (context, model, _) =>
          model.hasGroups() ? _buildListView(model) : _buildNoGroups(),
    );
  }

  Widget _buildNoGroups() {
    return const EmptyListLabel(
      message: "No groups have been created yet.\n"
          "You can create a new group below.",
    );
  }

  Widget _buildListView(GroupsViewModel model) {
    final List<Group> groups = model.getGroups();
    return ListView.builder(
      itemBuilder: (context, index) =>
          _buildListItem(groups[index], model.isSelectedGroup(groups[index])),
      itemCount: groups.length,
    );
  }

  Widget _buildListItem(Group group, bool selected) {
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

  Widget _bottomSheet() {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        title: TextField(
          controller: _textEditingController,
          decoration: const InputDecoration(labelText: "Create new group"),
          onSubmitted: (groupName) => _saveGroup(groupName),
        ),
        trailing: IconButton(
          onPressed: () => _saveGroup(_textEditingController.text),
          icon: const Icon(Icons.done),
        ),
      ),
    );
  }

  void _saveGroup(String groupName) {
    groupName = groupName.trim();
    if (groupName.isEmpty) {
      return;
    }
    final GroupsViewModel model = locator<GroupsViewModel>();
    if (model.groupAlreadyExists(groupName)) {
      ToastUtil.showError(message: "Group $groupName already exists!");
      return;
    }
    model.newGroup(
      Group(id: CommonUtil.generateRandomId(), name: groupName),
    );
    _textEditingController.clear();
    CommonUtil.hideKeypad();
  }

  void _handleGroupTap(String groupId) {
    locator<GroupsViewModel>().toggleSelectedId(groupId);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
