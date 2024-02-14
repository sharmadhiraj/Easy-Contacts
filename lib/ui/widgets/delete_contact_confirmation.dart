import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/services/contact_actions.dart';
import 'package:flutter/material.dart';

class DeleteContactConfirmationDialog extends StatelessWidget {
  const DeleteContactConfirmationDialog({required this.contact, super.key});

  final Contact contact;

  static void show({
    required BuildContext context,
    required Contact contact,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          DeleteContactConfirmationDialog(contact: contact),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete ${contact.firstName}?"),
      content: Text("Are you sure you want to delete ${contact.firstName}?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextButton(
          onPressed: () => ContactActions.deleteContact(context, contact),
          child: const Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
