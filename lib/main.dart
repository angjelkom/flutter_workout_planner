import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/adapters/profile.dart';
import 'package:flutter_workout_planner/adapters/workout.dart';
import 'package:flutter_workout_planner/managers/router.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //Allow only portrait mode on Android & iOS
  WidgetsFlutterBinding.ensureInitialized();
  //Make sure Hive is initialized first and only after register the adapter.
  await Hive.initFlutter();
  Hive.registerAdapter(ProfileAdapter());
  Hive.registerAdapter(WorkoutAdapter());
  runApp(const ProviderScope(child: WorkoutPlannerApp()));
}

class WorkoutPlannerApp extends ConsumerWidget {
  const WorkoutPlannerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerManager);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
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
      ),
    );
  }
}
