import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/managers/setup.dart';

import 'metric.dart';

class HeightPage extends ConsumerWidget {
  const HeightPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(setupManager);
    return MetricPage(
      title: 'How tall are you?',
      min: 62,
      max: 272,
      value: setup.height,
      unit: setup.heightUnit,
      onChanged: (value) => setup.height = value,
    );
  }
}
