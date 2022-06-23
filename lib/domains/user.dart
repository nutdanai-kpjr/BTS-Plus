import 'package:bts_plus/domains/rabbit_card.dart';
import 'package:bts_plus/main.dart';

class User {
  final String? id;
  final String userName;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  RabbitCard? rabbitCard;

  User(
      {this.id,
      required this.userName,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.birthDate,
      this.rabbitCard});

  User.fromJson(Map<String, dynamic> json,
      {required userName, required password})
      : userName = json['customerUser'] ?? userName,
        password = json['customerPassword'] ?? password,
        firstName = json['customerFirstName'],
        lastName = json['customerLastName'],
        birthDate = DateTime.parse(json['birthOfDate']),
        id = json['customerID'],
        rabbitCard = null;

  Map<String, dynamic> toJson() => {
        'customerID': id,
        'customerUser': userName,
        'customerPassword': password,
        'customerFirstName': firstName,
        'customerLastName': lastName,
        'birthOfDate': birthDate.toIso8601String(),
        'rabbitCard': rabbitCard?.toJson(),
      };

  User.mockUp()
      : userName = 'userName',
        password = 'password',
        id = 'a',
        firstName = 'firstName',
        lastName = 'lastName',
        birthDate = DateTime.now(),
        rabbitCard = null;

  String get fullName => '$firstName $lastName';
}
