import 'package:bts_plus/components/utils.dart';

class RabbitCard {
  final String? cardNumber;
  final String? pin;
  final String? firstName;
  final String? lastName;
  final String? userName;
  final String? btsUserId;
  final DateTime birthDate;
  final double balance;
  final String? type;

  RabbitCard(
      {this.cardNumber,
      this.btsUserId,
      required this.pin,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.birthDate,
      required this.balance,
      this.type});

  RabbitCard.fromJson(Map<String, dynamic> json, {required cardNumber})
      : cardNumber = json['rabbitNumber'] ?? cardNumber,
        pin = json['rabbitPassword'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        userName = json['rabbitUser'],
        birthDate = DateTime.parse(json['dateOfBirth']),
        balance = json['rabbitBalance'],
        btsUserId = json['customerID'],
        type = getCapitalized(json['rabbitType']);

  Map<String, dynamic> toJson() => {
        // 'rabbitNumber': cardNumber,
        'rabbitPassword': pin,
        'rabbitUser': userName,
        'firstName': firstName,
        'lastName': lastName,
        'dateOfBirth': birthDate.toIso8601String(),
        // 'rabbitBalance': balance,
        // 'rabbitType': type?.toUpperCase() ?? 'ADULT',
        'customerID': btsUserId,
      };
}
