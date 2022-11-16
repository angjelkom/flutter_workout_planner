import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/models/exercise.dart';

class ExerciseItem extends ConsumerStatefulWidget {
  const ExerciseItem({super.key, required this.exercise, required this.onTap});

  final Exercise exercise;
  final VoidCallback onTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExerciseItemState();
}

class _ExerciseItemState extends ConsumerState<ExerciseItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        children: [
          Image.asset('assets/${widget.exercise.icon}'),
          Text(widget.exercise.name)
        ],
      ),
    );
  }
}
