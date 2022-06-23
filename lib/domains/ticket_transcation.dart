import 'package:bts_plus/domains/ticket.dart';

class TicketTransaction {
  final String? userId;
  String from;
  String to;
  int quantity;
  double? totalPrice;
  double? discount;
  double? finalPrice;
  double? pricePerTicket;

  TicketTransaction(
      {required this.userId,
      required this.from,
      required this.to,
      required this.quantity,
      this.totalPrice,
      this.discount,
      this.finalPrice,
      this.pricePerTicket});

  TicketTransaction.fromJson(Map<String, dynamic> json)
      : userId = json['customerID'],
        from = json['from'],
        to = json['to'],
        quantity = json['numberTicket'],
        totalPrice = json['amount'],
        discount = json['discount'],
        finalPrice = json['total'],
        pricePerTicket = json['pricePerTicket'];

  TicketTransaction.fromJsonByUpdatePrice(
    Map<String, dynamic> json, {
    required this.userId,
    required this.from,
    required this.to,
  })  : quantity = json['numberTicket'],
        totalPrice = json['amount'],
        discount = json['discount'],
        finalPrice = json['total'],
        pricePerTicket = json['pricePerTicket'];
}
