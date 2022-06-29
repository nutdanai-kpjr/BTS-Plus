import '../services/base_controller.dart';

class TicketTransaction {
  final String? userId;
  String from;
  String to;
  int quantity;
  double? totalPrice;
  double? discount;
  double? finalPrice;
  double? pricePerTicket;
  final String shopNumber = kBTSshopNumber;

  bool get isValid => from != to;

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
        discount = json['discount'] * 1.0,
        finalPrice = json['total'] * 1.0,
        pricePerTicket = json['pricePerTicket'] * 1.0;

  TicketTransaction.fromJsonByUpdatePrice(
    Map<String, dynamic> json, {
    required this.userId,
    required this.from,
    required this.to,
  })  : quantity = json['numberOfTicket'],
        totalPrice = json['totalPrice'] * 1.0,
        discount = json['discount'] * 1.0,
        finalPrice = json['finalPrice'] * 1.0,
        pricePerTicket = json['pricePerTicket'] * 1.0;

  Map<String, dynamic> toJson() => {
        'customerID': userId,
        'startStation': from,
        'endStation': to,
        'numberOfTicket': quantity,
        'totalPrice': totalPrice,
        'discount': discount,
        'finalPrice': finalPrice,
        'pricePerTicket': pricePerTicket,
        'rabbitShopNumber ': kBTSshopNumber,
      };

  //override equals method to compare two TicketTransaction objects
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketTransaction && from == other.from && to == other.to;

  //override hashCode method to compare two TicketTransaction objects
  @override
  int get hashCode => from.hashCode ^ to.hashCode;
}
