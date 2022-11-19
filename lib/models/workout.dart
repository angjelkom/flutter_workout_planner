import 'dart:ui';

import 'package:flutter_workout_planner/models/exercise.dart';
import 'package:flutter_workout_planner/models/workout_set.dart';
import 'package:json_annotation/json_annotation.dart';

import '../adapters/color_converter.dart';

part 'workout.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class Workout {
  String? id;
  final String name;
  final Exercise exercise;
  final List<WorkoutSet> sets;
  final Duration? rest;

  @ColorConverter()
  final Color? color;
  final String notes;

  Workout(this.id, this.name, this.exercise, this.sets, this.rest, this.color,
      this.notes);

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutToJson(this);
}
