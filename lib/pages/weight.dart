import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/managers/setup.dart';

import 'metric.dart';

class WeightPage extends ConsumerWidget {
  const WeightPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(setupManager);
    return MetricPage(
      title: 'What\'s your weight?',
      min: 2,
      max: 635,
      value: setup.weight,
      unit: setup.weightUnit,
      onChanged: (value) => setup.weight = value,
    );
  }
}
