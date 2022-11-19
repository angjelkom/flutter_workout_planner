import 'package:flutter/material.dart';
import 'package:flutter_workout_planner/models/workout_set.dart';
import 'package:uuid/uuid.dart';

class WorkoutSetField {
  final String id;
  final TextEditingController sets;
  final TextEditingController reps;
  final TextEditingController weight;

  void setSets(int amount) {
    sets.text = '$amount';
  }

  void setReps(int amount) {
    reps.text = '$amount';
  }

  void setWeight(int amount) {
    weight.text = '$amount';
  }

  void dispose() {
    sets.dispose();
    reps.dispose();
    weight.dispose();
  }

  WorkoutSetField.fromData(WorkoutSet workoutSet)
      : id = const Uuid().v1(),
        sets = TextEditingController(text: '${workoutSet.sets}'),
        reps = TextEditingController(text: '${workoutSet.reps}'),
        weight = TextEditingController(text: '${workoutSet.weight}');

  WorkoutSet toData() =>
      WorkoutSet.fromData(id, sets.text, reps.text, weight.text);

  WorkoutSetField.init()
      : id = const Uuid().v1(),
        sets = TextEditingController(),
        reps = TextEditingController(),
        weight = TextEditingController();

  WorkoutSetField.fromJson(Map<String, dynamic> json)
      : id = const Uuid().v1(),
        sets = TextEditingController(text: '${json['sets']}'),
        reps = TextEditingController(text: '${json['reps']}'),
        weight = TextEditingController(text: '${json['weight']}');

  Map<String, dynamic> toJson() =>
      {'id': id, 'sets': sets.text, 'reps': reps.text, 'weight': weight.text};
}
