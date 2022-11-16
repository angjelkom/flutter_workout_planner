import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class WorkoutSet {
  final String id = const Uuid().v1();
  final TextEditingController sets = TextEditingController();
  final TextEditingController reps = TextEditingController();
  final TextEditingController weight = TextEditingController();

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
}
