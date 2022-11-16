import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/screens/workout.dart';
import 'package:flutter_workout_planner/screens/workouts.dart';
import 'package:flutter_workout_planner/widgets/app_scaffold.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(WorkoutPlannerApp());

class WorkoutPlannerApp extends StatelessWidget {
  WorkoutPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: 'Workout Planner',
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: Theme.of(context)
              .appBarTheme
              .copyWith(backgroundColor: Colors.black),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, // foreground (text) color
            ),
          ),
          // appBarTheme: const AppBarTheme(backgroundColor: backgroundColor)
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: Theme.of(context)
              .appBarTheme
              .copyWith(backgroundColor: Colors.black),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, // foreground (text) color
            ),
          ),
          // appBarTheme: const AppBarTheme(backgroundColor: backgroundColor)
        ),
      ),
    );
  }

  late final GoRouter _router = GoRouter(
    initialLocation: '/workouts',
    routes: [
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
                    return Container();
                  },
                ),
              ]),
        ],
      ),
    ],
  );
}
