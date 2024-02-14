import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/services/contacts.service.dart';
import 'package:stacked/stacked.dart';

class ContactDetailViewModel extends ReactiveViewModel {
  final ContactsService _contactsService = locator<ContactsService>();
  final String id;

  ContactDetailViewModel(this.id);

  Contact? getContact() {
    return _contactsService.getById(id);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_contactsService];
}
