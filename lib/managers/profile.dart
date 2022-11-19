import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/profile.dart';

class ProfileManager extends StateNotifier<Profile?> {
  ProfileManager() : super(null);

  void setProfile(Profile profile) {
    state = profile;
  }

  void clear() {
    state = null;
  }
}

final profileManager = StateNotifierProvider<ProfileManager, Profile?>((ref) {
  return ProfileManager();
});
