import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../domains/rabbit_transaction.dart';
import '../domains/user.dart';
import 'base_controller.dart';

const String kRabbitShopController = "$kRabbitBasedURL/api/v1/rabbitShop";
const String kInternalRabbitShopController = "$kRabbitBasedURL/api/v1/internal";

Future<User?> addUser(
  User user, {
  required context,
}) async {
  if (kIsMockup) {
    User newUser = User(
        id: 'r-XOpYEBukIohEcRRtxn',
        userName: user.userName,
        password: user.password,
        shopName: user.shopName,
        shopType: user.shopType,
        shopBalance: user.shopBalance);
    return newUser;
  }

  final response = await http.post(
      Uri.parse(
        '$kRabbitShopController/registerRabbitShop',
      ),
      headers: {"Content-Type": "application/json"},
      body: json.encode(user.toJson()));
  if (response.statusCode == 200) {
    return await loginUser(user.userName, user.password, context: context);
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return null;
  }
}

Future<User?> loginUser(String userName, String password,
    {required context}) async {
  if (kIsMockup) {
    var parsedJson = await jsonFromMockUpApi('get_rabbit_shop_user.json');
    User user =
        User.fromJson(parsedJson, userName: userName, password: password);
    return user;
  }
  final response = await http.get(Uri.parse(
    '$kRabbitShopController/getRabbitShop?rabbitShopUser=$userName&rabbitPassword=$password',
  ));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    User user =
        User.fromJson(parsedJson, userName: userName, password: password);
    return user;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return null;
    // }
    // }
  }
}

Future<List<RabbitTransaction>> getRabbitTransactions(rabbitShopId,
    {required context}) async {
  if (kIsMockup) {
    var parsedJson = await jsonFromMockUpApi('get_rabbit_transaction.json');
    List<RabbitTransaction> rabbitTransactions = parsedJson
        .map<RabbitTransaction>((json) => RabbitTransaction.fromJson(json))
        .toList();

    rabbitTransactions.sort((a, b) {
      return b.timeStamp.compareTo(a.timeStamp);
    });
    return [...rabbitTransactions];
  }

  final response = await http.get(Uri.parse(
    '$kRabbitShopController/transcationRabbitShop?rabbitShopID=$rabbitShopId',
  ));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    List<RabbitTransaction> rabbitTransactions = parsedJson
        .map<RabbitTransaction>((json) => RabbitTransaction.fromJson(json))
        .toList();

    rabbitTransactions.sort((a, b) {
      return b.timeStamp.compareTo(a.timeStamp);
    });
    return [...rabbitTransactions];
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return [];
    // }
    // }
  }
}

// get_rabbit_transactions.json
jsonFromMockUpApi(String apiPath) async {
  final mockUpRespond =
      await rootBundle.loadString('$kRabbitMockupURL/$apiPath');

  return jsonDecode(mockUpRespond);
}
