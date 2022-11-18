// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_workout_planner/main.dart' as app;
import 'package:flutter_workout_planner/managers/edit_workout.dart';
import 'package:flutter_workout_planner/screens/workout.dart';
import 'package:flutter_workout_planner/utils/const.dart';
import 'package:flutter_workout_planner/widgets/workout.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  testWidgets('Add Workout test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    // Build our app and trigger a frame.
    app.main();
    await tester.pumpAndSettle();

    expect(find.text('Add your first workout!'), findsOneWidget);

    final addButton = find.widgetWithText(ElevatedButton, 'Add');
    expect(addButton, findsOneWidget);
    await tester.tap(addButton);
    await tester.pump();

    final name = find.ancestor(
      of: find.text('Name'),
      matching: find.byType(TextField),
    );
    expect(name, findsOneWidget);

    const text = "My First Workout";
    await tester.enterText(name, text);
    await tester.pumpAndSettle();

    final elevatedButton = find.byWidgetPredicate((Widget widget) =>
        '${widget.runtimeType}' == '_ElevatedButtonWithIcon');

    final pickExercise = find.ancestor(
      of: find.text('Pick Exercise'),
      matching: elevatedButton,
    );
    expect(pickExercise, findsOneWidget);

    await tester.tap(pickExercise);
    await tester.pump();

    final exerciseWidget = find.byKey(ValueKey(exercises.first.id));
    await tester.tap(exerciseWidget);
    await tester.pump();

    final selectedExercise = find.ancestor(
      of: find.text(exercises.first.name),
      matching: elevatedButton,
    );
    expect(selectedExercise, findsOneWidget);

    final ref =
        tester.element<ConsumerStatefulElement>(find.byType(WorkoutScreen));
    final editManager = ref.read(editWorkoutManager);

    final sets = find.descendant(
      of: find.byKey(ValueKey(editManager.sets.first.id)),
      matching: find.byType(TextField),
    );

    var setsEvaluate = sets.evaluate();

    await tester.enterText(find.byWidget(setsEvaluate.first.widget), "2");
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byWidget(setsEvaluate.elementAt(1).widget), "4");
    await tester.pumpAndSettle();

    await tester.enterText(find.byWidget(setsEvaluate.last.widget), "10");
    await tester.pumpAndSettle();

    var removeSetButton = find.ancestor(
      of: find.text('Remove Set'),
      matching: elevatedButton,
    );
    expect(removeSetButton, findsNothing);

    final addDifferentSetButton = find.ancestor(
      of: find.text('Add Different Set'),
      matching: elevatedButton,
    );

    await tester.tap(addDifferentSetButton);
    await tester.pump();

    removeSetButton = find.ancestor(
      of: find.text('Remove Set'),
      matching: elevatedButton,
    );
    expect(removeSetButton, findsOneWidget);

    await tester.tap(removeSetButton);
    await tester.pump();

    removeSetButton = find.ancestor(
      of: find.text('Remove Set'),
      matching: elevatedButton,
    );
    expect(removeSetButton, findsNothing);

    final doneButton = find.ancestor(
      of: find.text('Done'),
      matching: find.byType(TextButton),
    );

    await tester.tap(doneButton);
    await tester.pump();

    final workout = find.ancestor(
      of: find.text(text),
      matching: find.byType(WorkoutWidget),
    );
    expect(workout, findsOneWidget);
  });
}
