import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_workout_planner/adapters/profile.dart';
import 'package:flutter_workout_planner/adapters/workout.dart';

import 'package:flutter_workout_planner/models/workout.dart';
import 'package:flutter_workout_planner/models/workout_set.dart';
import 'package:flutter_workout_planner/utils/utils.dart';
import 'package:flutter_workout_planner/widgets/workout.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

void main() {
  testWidgets('Workout Widget test', (WidgetTester tester) async {
    // Hive.init('${Directory.current.path}/test/add_workout_widget_test.dart');
    Hive.init('${Directory.current.path}/test/add_workout_wiidget_test.dart');
    Hive.registerAdapter(ProfileAdapter());
    Hive.registerAdapter(WorkoutAdapter());

    const uuid = Uuid();
    // Build our app and trigger a frame.
    final Workout workout = Workout(
        uuid.v1(),
        'My First Workout',
        exercises.first,
        [WorkoutSet(uuid.v1(), 2, 5, 8)],
        null,
        Colors.blue,
        'My Notes');

    final workoutWidget = MediaQuery(
        data: const MediaQueryData(),
        child: Material(
            child: Directionality(
                textDirection: TextDirection.ltr,
                child: WorkoutWidget(workout: workout))));

    await tester.pumpWidget(workoutWidget);

    final container = find.descendant(
      of: find.byType(Slidable),
      matching: find.byType(Container),
    );
    expect(container, findsOneWidget);

    final widget = tester.widget<Container>(container);
    final decoration = widget.decoration as BoxDecoration;

    expect(decoration.color, Colors.blue);
    expect(decoration.borderRadius, BorderRadius.circular(8.0));
  });
}
