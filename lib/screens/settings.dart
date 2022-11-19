import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/managers/edit_workout.dart';
import 'package:flutter_workout_planner/managers/profile.dart';
import 'package:flutter_workout_planner/managers/workouts.dart';
import 'package:flutter_workout_planner/utils/utils.dart';
import 'package:flutter_workout_planner/widgets/profile_field.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileManager);

    if (profile == null) return Container();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileField(label: 'Name', text: profile.name),
            ProfileField(label: 'Gender', text: profile.gender),
            ProfileField(label: 'Age', text: '${profile.getAge()}'),
            ProfileField(
                label: 'Height',
                text: '${profile.height}${profile.heightUnit}'),
            ProfileField(
                label: 'Weight',
                text: '${profile.weight}${profile.weightUnit}'),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    showConfirmDialog(context,
                        title: 'Remove Profile',
                        text:
                            'This will remove the profile along with all your workouts, continue?',
                        onConfirm: () {
                      ref.read(profileManager.notifier).clear();
                      ref.read(workoutsManager.notifier).clear();
                      ref.read(editWorkoutManager.notifier).clear();
                      context.go('/intro');
                    });
                  },
                  child: const Text('Remove Profile')),
            )
          ],
        ),
      ),
    );
  }
}
