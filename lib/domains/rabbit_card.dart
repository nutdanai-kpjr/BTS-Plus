import 'package:bts_plus/components/utils.dart';

class RabbitCard {
  final String? cardNumber;
  final String pin;
  final String firstName;
  final String lastName;
  final String userName;
  final DateTime birthDate;
  final double balance;
  final String type;

  RabbitCard(
      {this.cardNumber,
      required this.pin,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.birthDate,
      required this.balance,
      required this.type});

  RabbitCard.fromJson(Map<String, dynamic> json)
      : cardNumber = json['cardNumber'],
        pin = json['rabbitPassword'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        userName = json['rabbitUser'],
        birthDate = DateTime.parse(json['dateOfBirth']),
        balance = json['balance'],
        type = json['status'].toCapitalized();

  Map<String, dynamic> toJson() => {
        // '': cardNumber,
        'rabbitPassword': pin,
        'rabitUser': userName,
        'firstName': firstName,
        'lastName': lastName,
        'dateOfBirth': birthDate.toIso8601String(),
        'balance': balance,
        'status': type.toUpperCase(),
      };
}
