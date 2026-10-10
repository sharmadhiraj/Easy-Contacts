import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/utils/common.dart';
import 'package:easy_contacts/view_models/contacts.viewmodel.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
      locator<ContactsViewModel>().setSearchQuery(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: SearchBar(
        controller: _controller,
        hintText: "Search contacts",
        elevation: const WidgetStatePropertyAll(0),
        leading: const Icon(Icons.search),
        trailing: [
          if (_controller.text.isNotEmpty)
            IconButton(
              tooltip: "Clear search",
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                CommonUtil.hideKeypad();
              },
            ),
        ],
      ),
    );
  }
}
