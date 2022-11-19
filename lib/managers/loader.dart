import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoaderManager with ChangeNotifier {
  bool _profile = false;
  bool _workouts = false;

  bool get profile => _profile;
  bool get workouts => _workouts;

  set profile(bool profile) {
    _profile = profile;
    notifyListeners();
  }

  set workouts(bool workouts) {
    _workouts = workouts;
    notifyListeners();
  }
}

final loaderManager = ChangeNotifierProvider<LoaderManager>((ref) {
  return LoaderManager();
});
