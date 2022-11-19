import 'package:hive_flutter/hive_flutter.dart';

import '../models/workout.dart';

class WorkoutAdapter extends TypeAdapter<Workout> {
  @override
  final typeId = 1;

  @override
  Workout read(BinaryReader reader) {
    return Workout.fromJson(Map<String, dynamic>.from(reader.read()));
  }

  @override
  void write(BinaryWriter writer, Workout obj) {
    writer.write(obj.toJson());
  }
}
