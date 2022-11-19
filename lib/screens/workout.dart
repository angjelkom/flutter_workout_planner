import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../managers/edit_workout.dart';
import '../managers/workouts.dart';
import '../utils/utils.dart';
import '../widgets/workout_set.dart';
import 'exercise.dart';

class WorkoutScreen extends ConsumerStatefulWidget {
  const WorkoutScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends ConsumerState<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    final editManager = ref.watch(editWorkoutManager);
    const space = SizedBox(
      height: 24.0,
    );

    const smallerSpace = SizedBox(
      height: 8.0,
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: editManager.name,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            space,
            const Text('Exercise'),
            smallerSpace,
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    shape: editManager.exercise == null
                        ? null
                        : RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(color: Colors.blueGrey))),
                onPressed: _openExercises,
                icon: editManager.exercise != null
                    ? Image.asset(
                        'assets/${editManager.exercise!.icon}',
                        width: 48.0,
                      )
                    : const Icon(Icons.add),
                label: Text(editManager.exercise?.name ?? 'Pick Exercise')),
            space,
            const Text('Sets'),
            smallerSpace,
            Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: editManager.sets.length,
                  itemBuilder: (context, index) {
                    var set = editManager.sets[index];
                    return WorkoutSetWidget(
                      set: set,
                      key: ValueKey(set.id),
                    );
                  },
                ),
                space,
                if (editManager.sets.length > 1) ...[
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      onPressed: () {
                        ref.read(editWorkoutManager).removeSet();
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Remove Set')),
                  smallerSpace
                ],
                ElevatedButton.icon(
                    onPressed: () {
                      editManager.addSet();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Different Set')),
                space,
                Row(
                  children: [
                    const Text('Rest between sets:'),
                    const SizedBox(
                      width: 8.0,
                    ),
                    CupertinoSwitch(
                        activeColor: Colors.blue,
                        value: editManager.rest != null,
                        onChanged: (value) {
                          if (value) {
                            editManager.setRest(const Duration(seconds: 30));
                          } else {
                            editManager.setRest(null);
                          }
                        })
                  ],
                ),
                if (editManager.rest != null) ...[
                  smallerSpace,
                  SizedBox(
                    height: 96.0,
                    child: CupertinoTimerPicker(
                      initialTimerDuration: editManager.rest!,
                      mode: CupertinoTimerPickerMode.ms,
                      onTimerDurationChanged: (value) {
                        editManager.setRest(value);
                      },
                    ),
                  )
                ]
              ],
            ),
            space,
            const Text('Color'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: colors
                  .map((color) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            editManager.setColor(
                                color == Colors.transparent ? null : color);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32.0),
                                border: Border.all(
                                    color: editManager.color == color ||
                                            color == Colors.transparent &&
                                                editManager.color == null
                                        ? Colors.blue
                                        : Colors.transparent)),
                            child: Container(
                              width: 24.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                  color: color,
                                  border: color == Colors.transparent &&
                                          (editManager.color != null &&
                                              editManager.color != color)
                                      ? Border.all(color: Colors.blueGrey)
                                      : null,
                                  borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            space,
            TextField(
              controller: editManager.notes,
              decoration: const InputDecoration(labelText: 'Notes'),
            ),
            space,
            if (editManager.id != null)
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    onPressed: () {
                      showConfirmDialog(context,
                          title: 'Remove Profile',
                          text:
                              'This will remove the profile along with all your workouts, continue?',
                          onConfirm: () {
                        ref
                            .read(workoutsManager.notifier)
                            .remove(editManager.id!);
                        context.pop();
                      });
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Delete')),
              ),
            space
          ],
        ),
      ),
    );
  }

  void _openExercises() {
    OverlayEntry? overlay;
    overlay = OverlayEntry(
      builder: (context) {
        return ExerciseScreen(onDone: () {
          overlay!.remove();
        });
      },
    );

    Overlay.of(context, rootOverlay: true)?.insert(overlay);
  }
}
