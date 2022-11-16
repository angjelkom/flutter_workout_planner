import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/widgets/workout.dart';
import 'package:go_router/go_router.dart';

import '../managers/edit_workout.dart';
import '../managers/workouts.dart';

class WorkoutsScreen extends ConsumerStatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends ConsumerState<WorkoutsScreen> {
  @override
  Widget build(BuildContext context) {
    final workouts = ref.watch(workoutsManager);

    if (workouts.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add your first workout!',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 32.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 36.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(120.0),
                        side: const BorderSide(color: Colors.blueGrey))),
                onPressed: () {
                  ref.read(editWorkoutManager).reset();
                  context.go('/workouts/workout');
                },
                child: const Text('Add'))
          ],
        ),
      );
    }

    return ReorderableListView.builder(
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        var workout = workouts[index];
        return WorkoutWidget(
          workout: workout,
          key: ValueKey(workout.id),
        );
      },
      onReorder: (oldIndex, newIndex) {},
    );
  }
}
