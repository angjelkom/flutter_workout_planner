import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/exercise.dart';

const colors = [
  Colors.transparent,
  Colors.blue,
  Colors.red,
  Colors.pink,
  Colors.yellow,
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
