import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/managers/setup.dart';

class NamePage extends ConsumerStatefulWidget {
  const NamePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NamePageState();
}

class _NamePageState extends ConsumerState<NamePage> {
  @override
  Widget build(BuildContext context) {
    final setup = ref.watch(setupManager);
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Lastly, What\'s your name?',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 32.0,
          ),
          TextField(
            controller: setup.name,
            decoration: const InputDecoration(labelText: 'Name'),
          )
        ],
      ),
    );
  }
}
