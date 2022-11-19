import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/profile.dart';
import '../models/profile_data.dart';

class ProfileManager extends StateNotifier<ProfileData> {
  ProfileManager() : super(ProfileData(false)) {
    load();
  }

  void load() async {
    try {
      var box = await Hive.openBox<Profile>('profileBox');
      state = ProfileData(true, profile: box.getAt(0));
    } catch (e) {
      state = ProfileData(true);
    }
  }

  void setProfile(Profile profile) async {
    state = ProfileData(true, profile: profile);

    var box = await Hive.openBox<Profile>('profileBox');
    try {
      box.putAt(0, profile);
    } catch (e) {
      box.add(profile);
    }
  }

  void clear() async {
    state = ProfileData(true);

    var box = await Hive.openBox<Profile>('profileBox');
    box.clear();
  }
}

final profileManager =
    StateNotifierProvider<ProfileManager, ProfileData>((ref) {
  return ProfileManager();
});
