import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/managers/setup.dart';

class AgePage extends ConsumerStatefulWidget {
  const AgePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AgePageState();
}

class _AgePageState extends ConsumerState<AgePage> {
  final DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final setup = ref.watch(setupManager);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'How old are you?',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          height: 64.0,
        ),
        SizedBox(
          height: 200.0,
          child: CupertinoDatePicker(
            initialDateTime: setup.birth,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {
              setup.birth = value;
            },
          ),
        )
      ],
    );
  }
}
