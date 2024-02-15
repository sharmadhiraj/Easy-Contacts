import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/utils/common.dart';
import 'package:easy_contacts/view_models/contacts.viewmodel.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _textEditingController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() => _searchQuery = _textEditingController.text);
      locator<ContactsViewModel>().setSearchQuery(_searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.all(8),
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: "Search with name ...",
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          suffixIcon: IconButton(
            icon: Icon(_searchQuery.isEmpty ? Icons.search : Icons.clear),
            onPressed: () {
              _textEditingController.clear();
              CommonUtil.hideKeypad();
            },
          ),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
