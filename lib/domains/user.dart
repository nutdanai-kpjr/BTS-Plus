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

  User.fromJson(Map<String, dynamic> json)
      : userName = json['userName'],
        password = json['password'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        birthDate = DateTime.parse(json['birthDate']),
        rabbitCard = json['rabbitCard'] != null
            ? RabbitCard.fromJson(json['rabbitCard'])
            : null;
  User.mockUp()
      : userName = 'userName',
        password = 'password',
        firstName = 'firstName',
        lastName = 'lastName',
        birthDate = DateTime.now(),
        rabbitCard = null;
}
