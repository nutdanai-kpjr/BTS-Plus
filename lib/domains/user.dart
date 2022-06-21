import 'package:bts_plus/domains/rabbit_card.dart';

class User {
  final String userName;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final RabbitCard? rabbitCard;

  User(
      {required this.userName,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.birthDate,
      this.rabbitCard});
}
