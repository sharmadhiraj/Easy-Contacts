import 'package:easy_contacts/app/route.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactListTile extends StatelessWidget {
  const ContactListTile({required this.contact, super.key});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => context.pushNamed(
          AppRoute.contactDetail.name,
          extra: contact.id,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.black12,
          child: Text(
            contact.getAvatar(),
            style: const TextStyle(
              fontSize: 16,
              color: Constant.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          contact.getFullName(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          contact.phoneNo,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: Constant.primaryColor,
        ),
      ),
    );
  }
}
