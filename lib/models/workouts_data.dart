import 'workout.dart';

class WorkoutsData {
  final bool loaded;
  final List<Workout> workouts;

  WorkoutsData(this.loaded, {this.workouts = const []});
}
