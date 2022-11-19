import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class MetricPage extends StatelessWidget {
  const MetricPage(
      {super.key,
      required this.title,
      required this.min,
      required this.max,
      required this.value,
      required this.unit,
      required this.onChanged});

  final String title;
  final int min;
  final int max;
  final double value;
  final String unit;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          height: 32.0,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecimalNumberPicker(
              selectedTextStyle: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.blue),
              value: value,
              minValue: min,
              maxValue: max,
              decimalPlaces: 1,
              onChanged: onChanged,
            ),
            Text(
              unit,
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        )
      ],
    );
  }
}
