import 'package:easy_contacts/models/contact.dart';
import 'package:hive/hive.dart';

class ContactAdapter extends TypeAdapter<Contact> {
  @override
  final int typeId = 1;

  @override
  Contact read(BinaryReader reader) {
    return Contact(
      id: reader.readString(),
      firstName: reader.readString(),
      lastName: reader.readString(),
      phoneNo: reader.readString(),
      nickName: reader.readString(),
      email: reader.readString(),
      groups: List<String>.from(reader.readList()),
      note: reader.readString(),
      relationship: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Contact obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.firstName);
    writer.writeString(obj.lastName);
    writer.writeString(obj.phoneNo);
    writer.writeString(obj.nickName);
    writer.writeString(obj.email);
    writer.writeList(obj.groups);
    writer.writeString(obj.note);
    writer.writeString(obj.relationship);
  }
}
