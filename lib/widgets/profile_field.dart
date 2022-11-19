import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  const ProfileField({super.key, required this.label, required this.text});

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8.0),
        Text(
          text,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }
}
