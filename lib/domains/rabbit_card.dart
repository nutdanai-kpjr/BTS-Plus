class RabbitCard {
  final String cardNumber;
  final String pin;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final double balance;
  final String type;

  RabbitCard(
      {required this.cardNumber,
      required this.pin,
      required this.firstName,
      required this.lastName,
      required this.birthDate,
      required this.balance,
      required this.type});
}
