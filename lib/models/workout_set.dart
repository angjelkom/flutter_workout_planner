import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class WorkoutSet {
  final String id = const Uuid().v1();
  final TextEditingController sets = TextEditingController();
  final TextEditingController reps = TextEditingController();
  final TextEditingController weight = TextEditingController();

  WorkoutSet();

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

  factory WorkoutSet.fromJson(Map<String, dynamic> json) => WorkoutSet()
    ..sets.text = json['sets']
    ..reps.text = json['reps']
    ..weight.text = json['weight'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'sets': sets.text, 'reps': reps.text, 'weight': weight.text};
}
