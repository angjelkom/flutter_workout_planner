import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/managers/edit_workout.dart';
import 'package:flutter_workout_planner/widgets/exercise.dart';

import '../utils/const.dart';

class ExerciseScreen extends ConsumerStatefulWidget {
  const ExerciseScreen({super.key, required this.onDone});

  final VoidCallback onDone;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends ConsumerState<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose an Exercise'),
        centerTitle: false,
        actions: [
          InkWell(
            onTap: widget.onDone,
            child: Row(
              children: const [Text('Done'), Icon(Icons.arrow_right)],
            ),
          )
        ],
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            var exercise = exercises[index];
            return ExerciseItem(
                exercise: exercise,
                key: ValueKey(exercise.id),
                onTap: () {
                  ref.read(editWorkoutManager).setExercise(exercise);
                  widget.onDone();
                });
          }),
    );
  }
}
