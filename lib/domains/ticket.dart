class Ticket {
  final String id;
  final String from;
  final String to;
  final double price;

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
  Ticket.mockUp()
      : id = '0',
        from = 'Asok',
        to = 'Siam',
        price = 100;
}
