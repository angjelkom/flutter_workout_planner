import 'package:flutter/material.dart';
import 'package:flutter_workout_planner/models/intro.dart';
import 'package:uuid/uuid.dart';

import '../models/exercise.dart';

const colors = [
  Colors.transparent,
  Colors.blue,
  Colors.red,
  Colors.pink,
  Colors.orange,
  Colors.green
];

const uuid = Uuid();

final exercises = [
  Exercise(uuid.v1(), 'Barbell Row', 'barbell-row.png'),
  Exercise(uuid.v1(), 'Bench Press', 'bench-press.png'),
  Exercise(uuid.v1(), 'Shoulder Press', 'shoulder-press.png'),
  Exercise(uuid.v1(), 'Deadlift', 'deadlift.png'),
  Exercise(uuid.v1(), 'Squat', 'squat.png'),
];

const intros = [
  Intro(
      'Welcome',
      'This is an introduction for the Workout Planner app made in Flutter.',
      'intro1.png'),
  Intro(
      'About the Introduction',
      'The introduction uses standard PageView widget combined with the dots_indicator package, so apart from the dots, everything else is vanilla.',
      'intro2.png'),
  Intro(
      'What do I use?',
      'The app uses Riverpod to manage the reactive state, the GoRouter package for navigation, Uuid to generate uuids for the mockup data and the DotsIndicator page for the dots seen bellow.',
      'intro3.png'),
  Intro(
      'Out of the box',
      'On the next screen I will present you with an idea that wasn\'t requested in the task, but as with this introduction screen it self I thought it would the best way to demonstrate my \'out of the box thinking\'.',
      'intro1.png'),
  Intro(
      'Out of the box',
      'And I will do that by providing the user with the inital profile setup which is mostly shown during the initial signup for apps like this.\n\nLet\'s Start.',
      'intro2.png'),
];

void showConfirmDialog(BuildContext context,
    {required String title,
    required String text,
    required VoidCallback onConfirm}) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'OK');
            onConfirm();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
