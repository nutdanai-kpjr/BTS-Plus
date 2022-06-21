import 'package:bts_plus/domains/user.dart';
import 'package:riverpod/riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, User?>(
  (ref) => AuthNotifier(null),
);

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier(User? state) : super(state);

  setCurrentUser(User user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }
}
