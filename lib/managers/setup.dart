import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/profile.dart';

enum ProfileValidator {
  ok("ok"),
  gender("Please select gender"),
  name("Please enter a Name");

  const ProfileValidator(this.message);
  final String message;
}

class SetupManager with ChangeNotifier {
  String? _gender;
  DateTime _birth = DateTime.now();
  double _height = 170.0;
  String _heightUnit = 'cm';
  double _weight = 64.0;
  String _weightUnit = 'kg';
  final TextEditingController _name = TextEditingController();

  String? get gender => _gender;
  DateTime get birth => _birth;
  double get height => _height;
  String get heightUnit => _heightUnit;
  double get weight => _weight;
  String get weightUnit => _weightUnit;
  TextEditingController get name => _name;

  set gender(String? gender) {
    _gender = gender;
    notifyListeners();
  }

  set birth(DateTime birth) {
    _birth = birth;
    notifyListeners();
  }

  set height(double height) {
    _height = height;
    notifyListeners();
  }

  set heightUnit(String heightUnit) {
    _heightUnit = heightUnit;
    notifyListeners();
  }

  set weight(double weight) {
    _weight = weight;
    notifyListeners();
  }

  set weightUnit(String weightUnit) {
    _weightUnit = weightUnit;
    notifyListeners();
  }

  Profile getProfile() {
    return Profile(_gender!, _birth, _height, _heightUnit, _weight, _weightUnit,
        _name.text);
  }

  ProfileValidator validate(double page) {
    if (page >= 0 && page < 1) {
      if (_gender == null) return ProfileValidator.gender;
    }
    if (page >= 4) {
      if (_name.text.isEmpty) return ProfileValidator.name;
    }

    return ProfileValidator.ok;
  }

  void clear() {
    _gender = null;
    _birth = DateTime.now();
    _height = 170.0;
    _weight = 64.0;
    _name.text = '';
    notifyListeners();
  }
}

final setupManager = ChangeNotifierProvider<SetupManager>((ref) {
  return SetupManager();
});
