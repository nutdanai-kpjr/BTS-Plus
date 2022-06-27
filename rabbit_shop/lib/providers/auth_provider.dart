import 'package:rabbit_shop/domains/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rabbit_shop/services/rabbit_shop_controller.dart';

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

  refreshUser(context) async {
    final user = state;
    if (user == null) {
      return;
    }
    final updatedUser =
        await loginUser(user.userName, user.password, context: context);

    setCurrentUser(updatedUser);
  }
}
