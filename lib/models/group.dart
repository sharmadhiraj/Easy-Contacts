import 'package:easy_contacts/models/base.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Group extends BaseModel {
  final String name;

  Group({
    required super.id,
    required this.name,
  });
}

class GroupAdapter extends TypeAdapter<Group> {
  @override
  final int typeId = 2;

  @override
  Group read(BinaryReader reader) {
    return Group(
      id: reader.readString(),
      name: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Group obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
  }
}
