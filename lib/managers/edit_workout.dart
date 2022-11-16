import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/models/exercise.dart';
import 'package:flutter_workout_planner/models/workout.dart';
import 'package:flutter_workout_planner/models/workout_set.dart';

class EditWorkoutManager with ChangeNotifier {
  String? _id;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _notes = TextEditingController();

  Exercise? _exercise;
  List<WorkoutSet> _sets = [WorkoutSet()];
  Duration? _rest;
  Color? _color;

  String? get id => _id;
  TextEditingController get name => _name;
  TextEditingController get notes => _notes;
  Exercise? get exercise => _exercise;
  List<WorkoutSet> get sets => _sets;
  Duration? get rest => _rest;
  Color? get color => _color;

  void setExercise(Exercise? exercise) {
    _exercise = exercise;
    notifyListeners();
  }

  void addSet() {
    _sets.add(WorkoutSet());
    notifyListeners();
  }

  void removeSet() {
    _sets.removeLast();
    notifyListeners();
  }

  void setRest(Duration? rest) {
    _rest = rest;
    notifyListeners();
  }

  void setColor(Color? color) {
    _color = color;
    notifyListeners();
  }

  @override
  void dispose() {
    for (var set in _sets) {
      set.dispose();
    }
    super.dispose();
  }

  Workout getWorkout() {
    return Workout(
        _id, _name.text, _exercise!, _sets, _rest, _color, _notes.text);
  }

  void reset() {
    _id = null;
    _name.text = '';
    _notes.text = '';
    _exercise = null;
    _sets = [WorkoutSet()];
    _rest = null;
    _color = null;
    notifyListeners();
  }

  void open(Workout workout) {
    _id = workout.id;
    _name.text = workout.name;
    _notes.text = workout.notes;
    _exercise = workout.exercise;
    _sets = workout.sets;
    _rest = workout.rest;
    _color = workout.color;
  }
}

final editWorkoutManager = ChangeNotifierProvider<EditWorkoutManager>((ref) {
  return EditWorkoutManager();
});
