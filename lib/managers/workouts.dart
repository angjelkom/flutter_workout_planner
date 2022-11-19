import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/models/workout.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/workouts_data.dart';

class WorkoutsManager extends StateNotifier<WorkoutsData> {
  WorkoutsManager() : super(WorkoutsData(false)) {
    load();
  }

  void load() async {
    try {
      var box = await Hive.openBox<Workout>('workoutBox');
      state = WorkoutsData(true, workouts: box.values.toList());
    } catch (e) {
      state = WorkoutsData(true);
    }
  }

  void add(Workout workout) {
    if (workout.id == null) {
      workout.id = const Uuid().v1();
      state = WorkoutsData(true, workouts: [...state.workouts, workout]);
    } else {
      state = WorkoutsData(true, workouts: [
        for (final existingWorkout in state.workouts)
          if (existingWorkout.id == workout.id) workout else existingWorkout,
      ]);
    }
    save(workout);
  }

  void remove(String id) async {
    state = WorkoutsData(true,
        workouts: state.workouts.where((workout) => workout.id != id).toList());

    var box = await Hive.openBox<Workout>('workoutBox');
    box.delete(id);
  }

  void clear() async {
    state = WorkoutsData(true);

    var box = await Hive.openBox<Workout>('workoutBox');
    box.clear();
  }

  void save(Workout workout) async {
    var box = await Hive.openBox<Workout>('workoutBox');
    try {
      box.putAt(0, workout);
    } catch (e) {
      box.add(workout);
    }
  }
}

final workoutsManager =
    StateNotifierProvider<WorkoutsManager, WorkoutsData>((ref) {
  return WorkoutsManager();
});
