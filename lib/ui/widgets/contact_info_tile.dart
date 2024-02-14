import 'package:flutter/material.dart';

class ContactInfoTile extends StatelessWidget {
  const ContactInfoTile({
    required this.label,
    required this.value,
    required this.icon,
    super.key,
  });

  final String label, value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
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
