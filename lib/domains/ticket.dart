class Ticket {
  final String id;
  final String from;
  final String to;
  final double price;
// Timeout/ ออกตั๋ว
// Timeup/ หมดอายุ
// status/ สถานะตั๋ว
  Ticket(
      {required this.id,
      required this.from,
      required this.to,
      required this.price});
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
        from = json['from'],
        to = json['to'],
        price = json['price'];

  Ticket.mockUp()
      : id = '0',
        from = 'Asok',
        to = 'Siam',
        price = 100;
}
