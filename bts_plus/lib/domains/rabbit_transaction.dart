import '../components/utils.dart';

class RabbitTransaction {
  final String id;
  final double amount;
  final String? shopName;
  final String? shopType;
  final String transactiontype;
  final DateTime timeStamp;
  RabbitTransaction(
      {required this.id,
      required this.amount,
      required this.shopName,
      required this.shopType,
      required this.transactiontype,
      required this.timeStamp});
  RabbitTransaction.fromJson(Map<String, dynamic> json)
      : id = json['transactionRabbitCardID'],
        amount = json['amount'],
        shopName = json['rabbitShopName'],
        shopType = json['shopType'],
        transactiontype = json['transactionType'],
        timeStamp = DateTime.parse(json['timeStamp']);

  RabbitTransaction.mockUp()
      : id = '0',
        amount = 100,
        shopName = 'Green Marvin',
        shopType = 'LAZADA',
        transactiontype = 'BUY',
        timeStamp = DateTime.now();

  bool isIncome() {
    return transactiontype == 'TOPUP';
  }

  String get displayTransactionType {
    if (transactiontype == 'TOPUP') {
      return 'Topup';
    } else if (transactiontype == 'BUY') {
      return 'Pay';
    } else {
      return 'Charge';
    }
  }

  String get title {
    String newTitle = '${displayTransactionType}';
    if (shopType != null) {
      newTitle +=
          ' on ' + (shopType != "BTS" ? '${getCapitalized(shopType!)}' : 'BTS');
    }
    if (shopName != null) {
      newTitle += ' - ${shopName}';
    }
    return newTitle;
  }
}
