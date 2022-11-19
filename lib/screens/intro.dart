import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/managers/profile.dart';
import 'package:flutter_workout_planner/managers/setup.dart';
import 'package:go_router/go_router.dart';

import '../utils/utils.dart';

class IntroScreen extends ConsumerStatefulWidget {
  const IntroScreen(
      {super.key,
      required this.pages,
      required this.onDoneRoute,
      this.doneText,
      this.skipToBeforeLastPage = false,
      this.hideSkip = false,
      this.showBack = false});

  final List<Widget> pages;
  final String onDoneRoute;
  final String? doneText;
  final bool skipToBeforeLastPage;
  final bool hideSkip;
  final bool showBack;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {
  late final PageController _controller = PageController()
    ..addListener(() {
      setState(() {
        _page = _controller.page!;
      });
    });

  double _page = 0.0;

  void _onSkip() {
    _controller.animateToPage(widget.pages.length - 2,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  bool _validate() {
    if (widget.onDoneRoute == '/setup') return true;

    var result = ref.read(setupManager).validate(_page);
    if (result == ProfileValidator.ok) return true;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        result.message,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      backgroundColor: Colors.blue,
      duration: const Duration(milliseconds: 700),
    ));
    return false;
  }

  void _onNext() {
    if (_validate()) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
    }
  }

  void _onBack() {
    _controller.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  void _onDone() {
    if (widget.onDoneRoute == '/workouts') {
      if (_validate()) {
        var profile = ref.read(setupManager).getProfile();
        ref.read(profileManager.notifier).setProfile(profile);
        context.go(widget.onDoneRoute);
      }
    } else {
      context.go(widget.onDoneRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDone = _page + 1.5 >= widget.pages.length;

    return Scaffold(
      appBar: AppBar(
          actions: widget.hideSkip ||
                  isDone ||
                  widget.skipToBeforeLastPage &&
                      _page + 2.5 >= widget.pages.length
              ? null
              : [
                  TextButton(
                      onPressed:
                          widget.skipToBeforeLastPage ? _onSkip : _onDone,
                      child: const Text('Skip')),
                ]),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: intros.length,
              itemBuilder: (context, index) {
                return widget.pages[index];
              },
              controller: _controller,
            ),
          ),
          Stack(
            children: [
              if (widget.showBack && _page >= .5)
                Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                        onPressed: _onBack, child: const Text('Back'))),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: DotsIndicator(
                    dotsCount: widget.pages.length,
                    position: _page,
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: isDone ? _onDone : _onNext,
                      child: Text(isDone ? widget.doneText ?? 'Done' : 'Next')))
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

//Credits:
//<a href="https://lovepik.com/images/png-female.html">Female Png vectors by Lovepik.com</a>
//<a href="https://lovepik.com/images/png-dumbbells.html">Dumbbells Png vectors by Lovepik.com</a>
//<a href="https://lovepik.com/images/png-fitness.html">Fitness Png vectors by Lovepik.com</a>