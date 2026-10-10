import 'package:easy_contacts/app/route.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/ui/widgets/group_selector.dart';
import 'package:easy_contacts/utils/validation.dart';
import 'package:easy_contacts/view_models/contact_add_edit.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

class AddEditContactWidget extends StatefulWidget {
  const AddEditContactWidget({this.contact, super.key});

  final Contact? contact;

  static void show({
    required BuildContext context,
    Contact? contact,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: 560),
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) => AddEditContactWidget(contact: contact),
    );
  }

  @override
  State<AddEditContactWidget> createState() => _AddEditContactWidgetState();
}

class _AddEditContactWidgetState extends State<AddEditContactWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactAddEditViewModel>.reactive(
      viewModelBuilder: () => ContactAddEditViewModel(contact: widget.contact),
      builder: (context, viewModel, _) {
        return PopScope(
          canPop: !viewModel.hasChanges,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) {
              _confirmDiscard();
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Form(
                key: _formKey,
                onChanged: viewModel.markChanged,
                child: _buildFields(context, viewModel),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFields(BuildContext context, ContactAddEditViewModel viewModel) {
    final Contact contact = viewModel.contact;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        Text(
          viewModel.isUpdate ? "Update Contact" : "Add New Contact",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        _buildField(
          label: "First Name",
          initialValue: contact.firstName,
          onChanged: viewModel.setFirstName,
          validator: ValidationUtils.validateFirstName,
          keyboardType: TextInputType.name,
          capitalization: TextCapitalization.words,
        ),
        _buildField(
          label: "Last Name",
          initialValue: contact.lastName,
          onChanged: viewModel.setLastName,
          keyboardType: TextInputType.name,
          capitalization: TextCapitalization.words,
        ),
        _buildField(
          label: "Phone Number",
          initialValue: contact.phoneNo,
          onChanged: viewModel.setPhoneNo,
          validator: ValidationUtils.validatePhoneNumber,
          keyboardType: TextInputType.phone,
        ),
        _buildField(
          label: "Nick Name",
          initialValue: contact.nickName,
          onChanged: viewModel.setNickName,
          keyboardType: TextInputType.name,
          capitalization: TextCapitalization.words,
        ),
        _buildField(
          label: "Email",
          initialValue: contact.email,
          onChanged: viewModel.setEmail,
          keyboardType: TextInputType.emailAddress,
        ),
        GroupSelector(
          selectedGroups: contact.getGroups(),
          onSelectGroups: (List<Group> groups) {
            viewModel
              ..setGroups(groups.map((group) => group.id).toList())
              ..markChanged();
          },
        ),
        _buildField(
          label: "Relationship",
          initialValue: contact.relationship,
          onChanged: viewModel.setRelationship,
          capitalization: TextCapitalization.words,
        ),
        _buildField(
          label: "Note",
          initialValue: contact.note,
          onChanged: viewModel.setNote,
          capitalization: TextCapitalization.sentences,
          action: TextInputAction.done,
        ),
        const SizedBox(height: 4),
        FilledButton(
          onPressed: () => _save(context, viewModel),
          child: const Text("Save"),
        ),
      ],
    );
  }

  Widget _buildField({
    required String label,
    required String initialValue,
    required void Function(String) onChanged,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization capitalization = TextCapitalization.none,
    TextInputAction action = TextInputAction.next,
  }) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboardType,
      textCapitalization: capitalization,
      textInputAction: action,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(labelText: label),
    );
  }

  Future<void> _confirmDiscard() async {
    final bool? discard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Discard changes?"),
        content: const Text("Your unsaved changes will be lost."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Keep editing"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Discard"),
          ),
        ],
      ),
    );
    if (discard ?? false) {
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  void _save(BuildContext context, ContactAddEditViewModel viewModel) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final Contact? contact = viewModel.saveContact();
    if (contact != null) {
      Navigator.of(context).pop();
      if (!viewModel.isUpdate) {
        context.pushNamed(
          AppRoute.contactDetail.name,
          pathParameters: {"id": contact.id},
        );
      }
    }
  }
}
