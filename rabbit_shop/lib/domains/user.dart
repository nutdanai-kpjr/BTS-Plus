import 'package:rabbit_shop/components/utils.dart';

class User {
  final String? id;
  final String userName;
  final String password;
  final String shopName;
  final double? shopBalance;
  final String? shopNumber;
  final String shopType;
  User(
      {this.id,
      required this.userName,
      required this.password,
      required this.shopName,
      this.shopBalance,
      this.shopNumber,
      required this.shopType});

  factory User.fromJson(Map<String, dynamic> json,
      {required userName, required password}) {
    return User(
      id: json['rabbitShopID'],
      userName: userName,
      password: password,
      shopName: json['rabbitShopName'],
      shopNumber: json['rabbitShopNumber'],
      shopBalance: json['rabbitShopBalance'],
      shopType: json['shopType'],
    );
  }

  String get displayShopType =>
      shopType == 'BTS' ? 'BTS' : getCapitalized(shopType);
  Map<String, dynamic> toJson() {
    return {
      'rabbitShopID': id,
      'rabbitShopUser': userName,
      'rabbitShopPassword': password,
      "rabbitShopCheckPassword": password,
      'rabbitShopName': shopName,
      'shopNumber': shopNumber,
      'shopBalance': shopBalance,
      'shopType': shopType,
    };
  }
}
