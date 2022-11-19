import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/models/exercise.dart';
import 'package:flutter_workout_planner/models/workout.dart';
import 'package:flutter_workout_planner/models/workout_set_field.dart';

enum WorkoutValidator {
  ok("ok"),
  name("Please enter a Name"),
  exercise("Please select an Exercise"),
  oneSet("Please make sure at least one set is filled"),
  sets("Please make sure all your sets are filled"),
  set("Please fill your set"),
  rep("Please set the reps for your set"),
  weight("Please set the weight on your set"),
  zeroSets("Number of sets must be higher than zero."),
  zeroReps("Number of reps must be higher than zero.");

  const WorkoutValidator(this.message);
  final String message;
}

class EditWorkoutManager with ChangeNotifier {
  String? _id;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _notes = TextEditingController();

  Exercise? _exercise;
  List<WorkoutSetField> _sets = [WorkoutSetField.init()];
  Duration? _rest;
  Color? _color;

  String? get id => _id;
  TextEditingController get name => _name;
  TextEditingController get notes => _notes;
  Exercise? get exercise => _exercise;
  List<WorkoutSetField> get sets => _sets;
  Duration? get rest => _rest;
  Color? get color => _color;

  void setExercise(Exercise? exercise) {
    _exercise = exercise;
    notifyListeners();
  }

  void addSet() {
    _sets.add(WorkoutSetField.init());
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
    clear();
    _name.dispose();
    _notes.dispose();
    super.dispose();
  }

  Workout getWorkout() {
    return Workout(_id, _name.text, _exercise!,
        _sets.map((set) => set.toData()).toList(), _rest, _color, _notes.text);
  }

  void clear() {
    _id = null;
    _name.text = '';
    _notes.text = '';
    _exercise = null;
    for (var set in _sets) {
      set.dispose();
    }
    _sets = [WorkoutSetField.init()];
    _rest = null;
    _color = null;
    notifyListeners();
  }

  void open(Workout workout) {
    _id = workout.id;
    _name.text = workout.name;
    _notes.text = workout.notes;
    _exercise = workout.exercise;

    for (var set in _sets) {
      set.dispose();
    }
    _sets = [];

    for (var set in workout.sets) {
      _sets.add(WorkoutSetField.fromData(set));
    }

    _rest = workout.rest;
    _color = workout.color;
  }

  WorkoutValidator validate() {
    if (_name.text.isEmpty) return WorkoutValidator.name;
    if (_exercise == null) return WorkoutValidator.exercise;
    if (_sets.length == 1 &&
        _sets.first.sets.text.isEmpty &&
        _sets.first.reps.text.isEmpty &&
        _sets.first.weight.text.isEmpty) return WorkoutValidator.oneSet;

    for (var set in _sets) {
      if (set.sets.text.isEmpty &&
          set.reps.text.isEmpty &&
          set.weight.text.isEmpty) return WorkoutValidator.sets;
      if (set.sets.text.isEmpty) return WorkoutValidator.set;
      if (set.reps.text.isEmpty) return WorkoutValidator.rep;
      if (set.weight.text.isEmpty) return WorkoutValidator.weight;
      if (set.sets.text == '0') return WorkoutValidator.zeroSets;
      if (set.reps.text == '0') return WorkoutValidator.zeroReps;
    }

    if (_sets.first.sets.text.isEmpty &&
        _sets.first.reps.text.isEmpty &&
        _sets.first.weight.text.isEmpty) return WorkoutValidator.oneSet;
    if (_exercise == null) return WorkoutValidator.exercise;

    return WorkoutValidator.ok;
  }
}

final editWorkoutManager = ChangeNotifierProvider<EditWorkoutManager>((ref) {
  return EditWorkoutManager();
});
