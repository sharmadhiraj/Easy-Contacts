import 'package:hive_flutter/hive_flutter.dart';

class Contact {
  final String id;
  String firstName;
  String lastName;
  String phoneNo;
  String nickName;
  String email;
  List<String> groups;
  String note;
  String relationship;

  Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    required this.nickName,
    required this.email,
    required this.groups,
    required this.note,
    required this.relationship,
  });

  String getFullName() {
    return "$firstName $lastName".trim();
  }

  String getAvatar() {
    return firstName.isEmpty ? " " : firstName[0].toUpperCase();
  }
}

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