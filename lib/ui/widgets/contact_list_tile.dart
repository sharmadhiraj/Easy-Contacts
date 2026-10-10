import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/app/route.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/view_models/contacts.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactListTile extends StatelessWidget {
  const ContactListTile({required this.contact, super.key});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Dismissible(
      key: ValueKey(contact.id),
      direction: DismissDirection.endToStart,
      background: ColoredBox(
        color: colors.errorContainer,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Icon(Icons.delete_outline, color: colors.onErrorContainer),
          ),
        ),
      ),
      onDismissed: (_) => _delete(context),
      child: Semantics(
        button: true,
        label: "Open ${contact.getFullName()}",
        child: ListTile(
          onTap: () => context.pushNamed(
            AppRoute.contactDetail.name,
            pathParameters: {"id": contact.id},
          ),
          leading: CircleAvatar(
            backgroundColor: colors.primaryContainer,
            foregroundColor: colors.onPrimaryContainer,
            child: Text(contact.getAvatar()),
          ),
          title: Text(
            contact.getFullName(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            contact.phoneNo,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  void _delete(BuildContext context) {
    final ContactsViewModel viewModel = locator<ContactsViewModel>();
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text("${contact.firstName} deleted"),
          action: SnackBarAction(
            label: "Undo",
            onPressed: () => viewModel.restoreContact(contact),
          ),
        ),
      );
    viewModel.removeContact(contact.id);
  }
}
