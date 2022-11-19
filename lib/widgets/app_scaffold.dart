import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/managers/edit_workout.dart';
import 'package:flutter_workout_planner/managers/workouts.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppScaffold extends ConsumerStatefulWidget {
  const AppScaffold({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends ConsumerState<AppScaffold> {
  int _currentIndex = 0;

  bool _validate() {
    var result = ref.read(editWorkoutManager).validate();
    if (result == WorkoutValidator.ok) return true;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        result.message,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      backgroundColor: Colors.blue,
      duration: const Duration(milliseconds: 700),
    ));
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).location;
    final workoutsData = ref.watch(workoutsManager);
    final workouts = workoutsData.workouts;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: location == '/workouts' || location == '/workouts/settings'
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
                        if (_validate()) {
                          ref
                              .read(workoutsManager.notifier)
                              .add(ref.read(editWorkoutManager).getWorkout());
                          context.pop();
                        }
                      },
                      child: const Text('Done'))
                ]
              : null,
        ),
        bottomNavigationBar:
            location == '/workouts' || location == '/workouts/settings'
                ? BottomNavigationBar(
                    selectedItemColor: Colors.blue,
                    currentIndex: _currentIndex,
                    onTap: ((value) {
                      if (value != _currentIndex) {
                        if (value == 0) {
                          context.pop();
                        } else {
                          context.go('/workouts/settings');
                        }
                        setState(() {
                          _currentIndex = value;
                        });
                      }
                    }),
                    items: const [
                        BottomNavigationBarItem(
                            icon: Icon(MdiIcons.dumbbell), label: 'Workouts'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.settings), label: 'Settings'),
                      ])
                : null,
        floatingActionButton: workouts.isEmpty || location != '/workouts'
            ? null
            : FloatingActionButton(
                onPressed: () {
                  ref.read(editWorkoutManager).clear();
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
