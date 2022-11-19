import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/models/workout_set_field.dart';

class WorkoutSetWidget extends ConsumerStatefulWidget {
  const WorkoutSetWidget({super.key, required this.set});

  final WorkoutSetField set;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WorkoutSetWidgetState();
}

class _WorkoutSetWidgetState extends ConsumerState<WorkoutSetWidget> {
  @override
  Widget build(BuildContext context) {
    const frontSpace = SizedBox(
      width: 4.0,
    );
    const behindSpace = SizedBox(
      width: 16.0,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            textAlign: TextAlign.end,
            keyboardType: TextInputType.number,
            controller: widget.set.sets,
          )),
          frontSpace,
          const Text('Sets'),
          behindSpace,
          Expanded(
              child: TextField(
            textAlign: TextAlign.end,
            keyboardType: TextInputType.number,
            controller: widget.set.reps,
          )),
          frontSpace,
          const Text('Reps'),
          behindSpace,
          Expanded(
              child: TextField(
            textAlign: TextAlign.end,
            keyboardType: TextInputType.number,
            controller: widget.set.weight,
          )),
          frontSpace,
          const Text('Kg'),
        ],
      ),
    );
  }
}
