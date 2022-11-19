import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage(
      {super.key,
      required this.title,
      required this.text,
      required this.image});

  final String title;
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(children: [
            Image.asset("assets/$image", height: 175.0),
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 32.0,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ]),
        ),
      ),
    );
  }
}
