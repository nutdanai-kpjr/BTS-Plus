import 'package:bts_plus/domains/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/rabbit_controller.dart';

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

  refreshUserRabbitCard(context) async {
    final user = state;
    if (user == null) {
      return;
    }
    final rabbitCard =
        await getRabbitCard(user.rabbitCard!.cardNumber, context: context);
    final updatedUser = state;
    updatedUser!.rabbitCard = rabbitCard;
    setCurrentUser(updatedUser);
  }
}
