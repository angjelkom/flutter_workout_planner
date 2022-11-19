import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/models/workout.dart';
import 'package:uuid/uuid.dart';

class WorkoutsManager extends StateNotifier<List<Workout>> {
  WorkoutsManager() : super([]);

  void add(Workout workout) {
    if (workout.id == null) {
      workout.id = const Uuid().v1();
      state = [...state, workout];
    } else {
      state = [
        for (final existingWorkout in state)
          if (existingWorkout.id == workout.id) workout else existingWorkout,
      ];
    }
  }

  void remove(String id) {
    state = state.where((workout) => workout.id != id).toList();
  }

  void clear() {
    state = [];
  }
}

final workoutsManager =
    StateNotifierProvider<WorkoutsManager, List<Workout>>((ref) {
  return WorkoutsManager();
});
