import 'package:bts_plus/domains/ticket.dart';

class TicketTransaction {
  String from;
  String to;
  int quantity;
  double? totalPrice;
  double? discount;
  double? finalPrice;

  TicketTransaction({
    required this.from,
    required this.to,
    required this.quantity,
    this.totalPrice,
    this.discount,
    this.finalPrice,
  });
}
