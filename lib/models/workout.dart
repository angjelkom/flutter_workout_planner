import 'dart:ui';

import 'package:flutter_workout_planner/models/exercise.dart';
import 'package:flutter_workout_planner/models/workout_set.dart';

class Workout {
  String? id;
  final String name;
  final Exercise exercise;
  final List<WorkoutSet> sets;
  final Duration? rest;
  final Color? color;
  final String notes;

  Workout(this.id, this.name, this.exercise, this.sets, this.rest, this.color,
      this.notes);
}
