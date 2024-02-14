import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/services/contact_actions.dart';
import 'package:easy_contacts/ui/widgets/contact_info_tile.dart';
import 'package:easy_contacts/ui/widgets/delete_contact_confirmation.dart';
import 'package:easy_contacts/utils/common.dart';
import 'package:easy_contacts/utils/constant.dart';
import 'package:easy_contacts/view_models/contact_detail.viewmodel.dart';
import 'package:flutter/material.dart';
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
      actions: _buildActionButtons(context, contact),
    );
  }

  List<Widget> _buildActionButtons(BuildContext context, Contact contact) {
    return [
      IconButton(
        onPressed: () => CommonUtil.launchPhoneNumber(contact.phoneNo),
        icon: const Icon(Icons.call_outlined),
      ),
      IconButton(
        onPressed: () => ContactActions.copyPhoneNumber(contact.phoneNo),
        icon: const Icon(Icons.copy_outlined),
      ),
      IconButton(
        onPressed: () => DeleteContactConfirmationDialog.show(
            context: context, contact: contact),
        icon: const Icon(Icons.delete_outline_rounded),
      ),
      IconButton(
        onPressed: () => ContactActions.editContact(context, contact),
        icon: const Icon(Icons.edit),
      ),
    ];
  }

  Widget _buildBody(Contact contact) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(contact),
          ContactInfoTile(
            label: "Phone Number",
            value: contact.phoneNo,
            icon: Icons.phone_outlined,
          ),
          ContactInfoTile(
            label: "Email",
            value: contact.email,
            icon: Icons.email_outlined,
          ),
          ContactInfoTile(
            label: "Groups",
            value: contact.getGroups(),
            icon: Icons.category_outlined,
          ),
          ContactInfoTile(
            label: "Relationship",
            value: contact.relationship,
            icon: Icons.group_outlined,
          ),
          ContactInfoTile(
            label: "Note",
            value: contact.note,
            icon: Icons.note_outlined,
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
}
