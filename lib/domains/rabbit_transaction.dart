class RabbitTransaction {
  final String title;
  final DateTime date;
  final double amount;
  RabbitTransaction(
      {required this.title, required this.date, required this.amount});
  RabbitTransaction.mockUp()
      : title = 'Rabbit Transaction',
        date = DateTime.now(),
        amount = 100;
}
