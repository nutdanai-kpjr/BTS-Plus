import '../components/utils.dart';

class RabbitTransaction {
  final String id;
  final double amount;
  final DateTime timeStamp;
  final String customerRabbitNumber;
  final String customerFirstName;
  final String customerLastName;
  final String customerType;

  RabbitTransaction(
      {required this.id,
      required this.amount,
      required this.timeStamp,
      required this.customerRabbitNumber,
      required this.customerFirstName,
      required this.customerLastName,
      required this.customerType});

  RabbitTransaction.fromJson(Map<String, dynamic> json)
      : id = json['transactionRabbitShopID'],
        amount = json['amount'],
        customerRabbitNumber = json['rabbitNumber'],
        customerFirstName = json['rabbitFirstName'],
        customerLastName = json['rabbitLastName'],
        customerType = json['rabbitStatus'],
        timeStamp = DateTime.parse(json['timeStamp']);

  RabbitTransaction.mockUp()
      : id = '1',
        amount = 100.0,
        customerRabbitNumber = '123456789',
        customerFirstName = 'John',
        customerLastName = 'Doe',
        customerType = 'Customer',
        timeStamp = DateTime.now();

  String get title =>
      'Received from ${getCapitalized(customerFirstName)} ${getCapitalized(customerLastName)}';
}
