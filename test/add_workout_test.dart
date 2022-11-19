// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_workout_planner/managers/edit_workout.dart';
import 'package:flutter_workout_planner/managers/workouts.dart';
import 'package:flutter_workout_planner/utils/utils.dart';

void main() {
  test('Add Workout test', () {
    final container = ProviderContainer();

    final editManager = container.read(editWorkoutManager);
    const name = 'My First Workout';
    const notes = 'Some note here';
    const sets = 4;
    const reps = 3;
    const weight = 10;
    const rest = Duration(seconds: 15);

    editManager.name.text = name;
    editManager.setExercise(exercises.first);
    editManager.sets.first.sets.text = '$sets';
    editManager.sets.first.reps.text = '$reps';
    editManager.sets.first.weight.text = '$weight';
    editManager.setRest(rest);
    editManager.setColor(colors.first);
    editManager.notes.text = notes;

    final workout = editManager.getWorkout();
    expect(workout.id, isNull);
    expect(workout.name, name);
    expect(workout.exercise, exercises.first);
    expect(workout.sets.first.sets.text, '$sets');
    expect(workout.sets.first.reps.text, '$reps');
    expect(workout.sets.first.weight.text, '$weight');
    expect(workout.rest, rest);
    expect(workout.color, colors.first);
    expect(workout.notes, notes);

    final notifier = container.read(workoutsManager.notifier);
    notifier.add(workout);
    expect(container.read(workoutsManager), isNotEmpty);

    notifier.remove(workout.id!);
    expect(container.read(workoutsManager), isEmpty);

    // Thanks to "container", we can read our provider.
  });
}
