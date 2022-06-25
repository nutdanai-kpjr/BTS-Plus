class Ticket {
  final String id;
  final String ticketNumber;
  final String buyerUserId;
  final String buyerFirstName;
  final String buyerLastName;
  final String fromStationId;
  final String toStationId;
  final double price;
  final double priceWithDiscount;
  final DateTime purchaseDate;
  final DateTime expireDate;
  final String? status;
  final int stationDistance;
// Timeout/ ออกตั๋ว
// Timeup/ หมดอายุ
// status/ สถานะตั๋ว
  Ticket(
      {required this.id,
      required this.ticketNumber,
      required this.buyerUserId,
      required this.buyerFirstName,
      required this.buyerLastName,
      required this.fromStationId,
      required this.toStationId,
      required this.price,
      required this.priceWithDiscount,
      required this.purchaseDate,
      required this.expireDate,
      required this.status,
      required this.stationDistance});
  // final Datetime date;
  // final String buyer;
  // final int stationDistance;
  // final double price;
  //buydate
  //buydate
  //status
  //
  Ticket.fromJson(Map<String, dynamic> json)
      : id = json['ticketID'],
        ticketNumber = json['ticketNumber'],
        buyerUserId = json['customerID'],
        buyerFirstName = json['customerFirstName'],
        buyerLastName = json['customerLastName'],
        fromStationId = json['startStation'],
        toStationId = json['endStation'],
        price = json['amount'],
        priceWithDiscount = json['finalAmount'],
        purchaseDate = DateTime.parse(json['dateAndTimeOut']),
        expireDate = DateTime.parse(json['dateAndTimeUp']),
        status = json['statusTrciket'],
        stationDistance = json['startToEnd'];
}
