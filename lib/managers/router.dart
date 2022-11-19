import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/managers/profile.dart';
import 'package:go_router/go_router.dart';

import '../pages/age.dart';
import '../pages/gender.dart';
import '../pages/height.dart';
import '../pages/intro.dart';
import '../pages/name.dart';
import '../pages/weight.dart';
import '../screens/intro.dart';
import '../screens/settings.dart';
import '../screens/workout.dart';
import '../screens/workouts.dart';
import '../utils/utils.dart';
import '../widgets/app_scaffold.dart';

final _navigatorKey = GlobalKey<NavigatorState>();
// We need to make sure we have access to the location of the previous router
// instance. Otherwise, we will always be redirected to '/' on rebuild.
GoRouter? _previousRouter;

final introPages = intros
    .map((intro) =>
        IntroPage(title: intro.title, text: intro.text, image: intro.image))
    .toList();

final routerManager = Provider<GoRouter>((ref) {
  final profileData = ref.watch(profileManager);
  return _previousRouter = GoRouter(
    navigatorKey: _navigatorKey,
    initialLocation: _previousRouter?.location ?? '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (BuildContext context, GoRouterState state) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        redirect: (context, state) {
          if (!profileData.loaded) return null;

          if (profileData.profile != null) return '/workouts';

          return '/intro';
        },
      ),
      GoRoute(
        path: '/intro',
        builder: (BuildContext context, GoRouterState state) {
          return IntroScreen(
            pages: introPages,
            doneText: 'Start',
            skipToBeforeLastPage: true,
            onDoneRoute: '/setup',
          );
        },
      ),
      GoRoute(
        path: '/intro',
        builder: (BuildContext context, GoRouterState state) {
          return IntroScreen(
            pages: introPages,
            doneText: 'Start',
            skipToBeforeLastPage: true,
            onDoneRoute: '/setup',
          );
        },
      ),
      GoRoute(
          path: '/setup',
          builder: (BuildContext context, GoRouterState state) {
            return const IntroScreen(
              hideSkip: true,
              showBack: true,
              pages: [
                GenderPage(),
                AgePage(),
                HeightPage(),
                WeightPage(),
                NamePage()
              ],
              onDoneRoute: '/workouts',
            );
          }),
      ShellRoute(
        builder: (context, state, child) {
          return AppScaffold(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
              path: '/workouts',
              builder: (BuildContext context, GoRouterState state) {
                return const WorkoutsScreen();
              },
              routes: [
                GoRoute(
                  path: 'workout',
                  builder: (BuildContext context, GoRouterState state) {
                    return const WorkoutScreen();
                  },
                ),
                GoRoute(
                  path: 'settings',
                  builder: (BuildContext context, GoRouterState state) {
                    return const SettingsScreen();
                  },
                ),
              ]),
        ],
      ),
    ],
  );
});
