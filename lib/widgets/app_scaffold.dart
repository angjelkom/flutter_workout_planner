import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/managers/edit_workout.dart';
import 'package:flutter_workout_planner/managers/workouts.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends ConsumerStatefulWidget {
  const AppScaffold({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends ConsumerState<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).location;
    final workouts = ref.watch(workoutsManager);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: location == '/workouts'
              ? null
              : IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)),
          title: Text(location == '/workouts'
              ? 'Workouts'
              : location == '/workouts/workout'
                  ? 'Workout'
                  : ''),
          actions: location == '/workouts/workout'
              ? [
                  TextButton(
                      onPressed: () {
                        ref
                            .read(workoutsManager.notifier)
                            .add(ref.read(editWorkoutManager).getWorkout());
                        context.pop();
                      },
                      child: const Text('Done'))
                ]
              : null,
        ),
        bottomNavigationBar: location == '/workouts'
            ? BottomNavigationBar(
                currentIndex: 0,
                onTap: ((value) {}),
                items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Workouts'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: 'Settings'),
                  ])
            : null,
        floatingActionButton: workouts.isEmpty || location != '/workouts'
            ? null
            : FloatingActionButton(
                onPressed: () {
                  ref.read(editWorkoutManager).reset();
                  context.go('/workouts/workout');
                },
                child: const Icon(Icons.add),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: widget.child,
      ),
    );
  }
}
