import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/managers/setup.dart';

class GenderWidget extends ConsumerWidget {
  const GenderWidget(
      {super.key,
      required this.icon,
      required this.name,
      this.color,
      this.colors});

  final IconData icon;
  final String name;

  final Color? color;
  final List<Color>? colors;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gender = ref.watch(setupManager.select((setup) => setup.gender));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () {
          ref.read(setupManager).gender = name;
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: gender == name
                            ? Colors.greenAccent
                            : Colors.transparent,
                        width: 4.0),
                    borderRadius: BorderRadius.circular(100.0)),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: color,
                      gradient: colors != null && colors!.isNotEmpty
                          ? LinearGradient(colors: colors!)
                          : null,
                      borderRadius: BorderRadius.circular(100.0)),
                  child: Icon(
                    icon,
                    size: 38.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(name)
            ],
          ),
        ),
      ),
    );
  }
}
