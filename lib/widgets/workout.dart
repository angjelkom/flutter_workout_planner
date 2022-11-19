import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/managers/edit_workout.dart';
import 'package:go_router/go_router.dart';

import '../models/workout.dart';

class WorkoutWidget extends ConsumerStatefulWidget {
  const WorkoutWidget({super.key, required this.workout});

  final Workout workout;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WorkoutWidgetState();
}

class _WorkoutWidgetState extends ConsumerState<WorkoutWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          ref.read(editWorkoutManager).open(widget.workout);
          context.go('/workouts/workout');
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: widget.workout.color,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/${widget.workout.exercise.icon}',
                      width: 100.0,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.workout.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text(widget.workout.exercise.name)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            FractionallySizedBox(
              widthFactor: .96,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0))),
                child: Column(
                  children: widget.workout.sets
                      .map((set) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  backgroundColor: widget.workout.color,
                                  radius: 4.0,
                                ),
                                Text('${set.sets} Sets'),
                                Text('${set.reps} Reps'),
                                Text('${set.weight} Kg'),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
