import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/services/groups.service.dart';
import 'package:easy_contacts/ui/widgets/add_edit_contact.dart';
import 'package:easy_contacts/utils/common.dart';
import 'package:easy_contacts/utils/constant.dart';
import 'package:easy_contacts/utils/toast.dart';
import 'package:easy_contacts/view_models/contact_detail.viewmodel.dart';
import 'package:easy_contacts/view_models/contacts.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class ContactDetailScreen extends StatelessWidget {
  const ContactDetailScreen({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactDetailViewModel>.reactive(
      viewModelBuilder: () => ContactDetailViewModel(id),
      builder: (context, model, _) {
        final Contact? contact = model.getContact();
        if (contact == null) return Container();
        return Scaffold(
          appBar: _buildAppBar(context, contact),
          body: _buildBody(contact),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, Contact contact) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () => CommonUtil.launchPhoneNumber(contact.phoneNo),
          icon: const Icon(Icons.call_outlined),
        ),
        IconButton(
          onPressed: () => _copyPhoneNumber(contact.phoneNo),
          icon: const Icon(Icons.copy_outlined),
        ),
        IconButton(
          onPressed: () => _showDeleteContactConfirmation(context, contact),
          icon: const Icon(Icons.delete_outline_rounded),
        ),
        IconButton(
          onPressed: () => _editContact(context, contact),
          icon: const Icon(Icons.edit),
        ),
      ],
    );
  }

  Widget _buildBody(Contact contact) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(contact),
          _buildItem(
            "Phone Number",
            contact.phoneNo,
            Icons.phone_outlined,
          ),
          _buildItem(
            "Email",
            contact.email,
            Icons.email_outlined,
          ),
          _buildItem(
            "Groups",
            locator<GroupsService>()
                .getGroupByIds(contact.groups)
                .map((group) => group.name)
                .join(", "),
            Icons.category_outlined,
          ),
          _buildItem(
            "Relationship",
            contact.relationship,
            Icons.group_outlined,
          ),
          _buildItem(
            "Note",
            contact.note,
            Icons.note_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(Contact contact) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAvatar(contact),
          const SizedBox(height: 8),
          Text(
            contact.getFullName(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (contact.nickName.isNotEmpty)
            Text(
              contact.nickName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            )
        ],
      ),
    );
  }

  Widget _buildAvatar(Contact contact) {
    return CircleAvatar(
      radius: 32,
      backgroundColor: Constant.primaryColor,
      child: Text(
        contact.getAvatar(),
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildItem(
    String label,
    String value,
    IconData icon,
  ) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          icon,
          color: Colors.black54,
        ),
      ),
      title: Text(
        label,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }

  void _copyPhoneNumber(String phoneNo) {
    Clipboard.setData(ClipboardData(text: phoneNo));
    ToastUtil.showInfo(message: "Phone number copied to clipboard.");
  }

  void _editContact(BuildContext context, Contact contact) {
    AddEditContactWidget.show(
      context: context,
      contact: contact,
    );
  }

  void _showDeleteContactConfirmation(BuildContext context, Contact contact) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete ${contact.firstName}?"),
          content:
              Text("Are you sure you want to delete ${contact.firstName}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () => _deleteContact(context, contact),
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteContact(BuildContext context, Contact contact) {
    locator<ContactsViewModel>().removeContact(contact.id);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    ToastUtil.showInfo(
      message: "Contact ${contact.firstName} deleted successfully.",
    );
  }
}
