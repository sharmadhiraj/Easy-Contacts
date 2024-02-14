import 'package:easy_contacts/models/contact.dart';
import 'package:flutter/material.dart';

class ContactDetailScreen extends StatelessWidget {
  const ContactDetailScreen({required this.contact, super.key});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar();
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          _buildItem("Phone Number", contact.phoneNo, Icons.phone_outlined),
          _buildItem("Email", contact.email, Icons.email_outlined),
          _buildItem("Note", contact.note, Icons.note_outlined),
          _buildItem(
              "Relationship", contact.relationship, Icons.group_outlined),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            contact.getFullName(),
            style: const TextStyle(
              fontSize: 22,
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
}
