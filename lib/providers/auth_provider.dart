import 'package:bts_plus/domains/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, User?>(
  (ref) => AuthNotifier(null),
  // (ref) => AuthNotifier(User.mockUp()),
);

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier(User? state) : super(state);

  setCurrentUser(User? user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }
}
