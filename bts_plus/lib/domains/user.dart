import 'dart:convert';

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
        'rabbitCard': rabbitCard,
      };
  Map<String, dynamic> toJsonNoPassword() => {
        'customerID': id,
        'customerUser': userName,
        'customerFirstName': firstName,
        'customerLastName': lastName,
        'birthOfDate': birthDate.toIso8601String(),
        'rabbitCard': rabbitCard,
      };

  String getQRurl() {
    return json.encode(toJsonNoPassword());
  }

  User.mockUp()
      : userName = 'userName',
        password = 'password',
        id = 'a',
        firstName = 'firstName',
        lastName = 'lastName',
        birthDate = DateTime.now(),
        rabbitCard = null;

  User copyWith({
    String? id,
    String? userName,
    String? password,
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    RabbitCard? rabbitCard,
  }) =>
      User(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        birthDate: birthDate ?? this.birthDate,
        rabbitCard: rabbitCard ?? this.rabbitCard,
      );

  String get fullName => '$firstName $lastName';
}
