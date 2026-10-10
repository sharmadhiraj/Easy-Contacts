import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/services/contact_actions.dart';
import 'package:easy_contacts/ui/widgets/contact_info_tile.dart';
import 'package:easy_contacts/ui/widgets/delete_contact_confirmation.dart';
import 'package:easy_contacts/utils/common.dart';
import 'package:easy_contacts/view_models/contact_detail.viewmodel.dart';
import 'package:easy_contacts/ui/widgets/content_width.dart';
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
        final Contact contact = model.getContact();
        return Scaffold(
          appBar: _buildAppBar(context, contact),
          body: ContentWidth(child: _buildBody(context, contact)),
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
        tooltip: "Edit",
        onPressed: () => ContactActions.editContact(context, contact),
        icon: const Icon(Icons.edit_outlined),
      ),
      IconButton(
        tooltip: "Delete",
        onPressed: () => DeleteContactConfirmationDialog.show(
          context: context,
          contact: contact,
        ),
        icon: const Icon(Icons.delete_outline_rounded),
      ),
    ];
  }

  Widget _buildBody(BuildContext context, Contact contact) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(context, contact),
          _buildQuickActions(contact),
          ContactInfoTile(
            label: "Phone Number",
            value: contact.phoneNo,
            icon: Icons.phone_outlined,
            trailing: IconButton(
              tooltip: "Copy phone number",
              onPressed: () => ContactActions.copyPhoneNumber(contact.phoneNo),
              icon: const Icon(Icons.copy_outlined),
            ),
          ),
          ContactInfoTile(
            label: "Email",
            value: contact.email,
            icon: Icons.email_outlined,
          ),
          if (contact.getGroups().isNotEmpty) _buildGroups(contact),
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

  Widget _buildHeader(BuildContext context, Contact contact) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: theme.colorScheme.primaryContainer,
            foregroundColor: theme.colorScheme.onPrimaryContainer,
            child: Text(
              contact.getAvatar(),
              style: theme.textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            contact.getFullName(),
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
          ),
          if (contact.nickName.isNotEmpty)
            Text(
              contact.nickName,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(Contact contact) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        children: [
          FilledButton.tonalIcon(
            onPressed: () => CommonUtil.launchPhoneNumber(contact.phoneNo),
            icon: const Icon(Icons.call_outlined),
            label: const Text("Call"),
          ),
          FilledButton.tonalIcon(
            onPressed: () => CommonUtil.launchSms(contact.phoneNo),
            icon: const Icon(Icons.message_outlined),
            label: const Text("Message"),
          ),
          if (contact.email.isNotEmpty)
            FilledButton.tonalIcon(
              onPressed: () => CommonUtil.launchEmail(contact.email),
              icon: const Icon(Icons.email_outlined),
              label: const Text("Email"),
            ),
        ],
      ),
    );
  }

  Widget _buildGroups(Contact contact) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: 8,
          children: [
            for (final Group group in contact.getGroups())
              Chip(label: Text(group.name)),
          ],
        ),
      ),
    );
  }
}
