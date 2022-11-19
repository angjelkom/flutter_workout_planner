import 'package:hive_flutter/hive_flutter.dart';

import '../models/profile.dart';

class ProfileAdapter extends TypeAdapter<Profile> {
  @override
  final typeId = 0;

  @override
  Profile read(BinaryReader reader) {
    return Profile.fromJson(Map<String, dynamic>.from(reader.read()));
  }

  @override
  void write(BinaryWriter writer, Profile obj) {
    writer.write(obj.toJson());
  }
}
