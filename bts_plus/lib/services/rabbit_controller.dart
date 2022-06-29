import 'dart:convert';
import 'dart:developer';

import 'package:bts_plus/domains/rabbit_card.dart';
import 'package:bts_plus/domains/rabbit_transaction.dart';
import 'package:bts_plus/services/bts_controller.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'base_controller.dart';

const String kRabbitControllerUrl = "$kRabbitBasedURL/api/v1/rabbitCard";

Future<bool> addRabbitCard(
  RabbitCard newRabbitCard, {
  required context,
}) async {
  if (kIsMockup) {
    return true;
  }
  final response = await http.post(
      Uri.parse(
        '$kRabbitControllerUrl/registerRabbitCardByBts',
      ),
      headers: {"Content-Type": "application/json"},
      body: json.encode(newRabbitCard.toJson()));
  if (response.statusCode == 200) {
    return true;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return false;
  }
}

Future<RabbitCard?> getRabbitCard(
  rabbitNumber, {
  required context,
}) async {
  if (kIsMockup) {
    var parsedJson =
        await jsonFromMockUpApi(context: context, 'get_rabbit_card.json');
    RabbitCard rabbitCard =
        RabbitCard.fromJson(parsedJson, cardNumber: rabbitNumber);
    return rabbitCard;
  }

  final response = await http.get(Uri.parse(
    '$kRabbitControllerUrl/connectRabbitCard?rabbitNumber=$rabbitNumber',
  ));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    RabbitCard rabbitCard =
        RabbitCard.fromJson(parsedJson, cardNumber: rabbitNumber);
    return rabbitCard;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return null;
  }
}

Future<List<RabbitTransaction>> getRabbitTransactions(rabbitId,
    {required context}) async {
  if (kIsMockup) {
    var parsedJson = await jsonFromMockUpApi(
        context: context, 'get_rabbit_transaction.json');

    List<RabbitTransaction> rabbitTransactions = parsedJson
        .map<RabbitTransaction>((json) => RabbitTransaction.fromJson(json))
        .toList();

    rabbitTransactions.sort((a, b) {
      return b.timeStamp.compareTo(a.timeStamp);
    });
    return rabbitTransactions;
  }
  final response = await http.get(Uri.parse(
    '$kRabbitControllerUrl/transcationRabbitCard?rabbitID=$rabbitId',
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
    return rabbitTransactions;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return [];
    // }
    // }
  }
}

Future<bool> topUpRabbitCard(
  String rabbitUserName,
  double amount, {
  required context,
}) async {
  if (kIsMockup) {
    return true;
  }
  final response = await http.post(Uri.parse(
    '$kInternalBTSControllerUrl/topRabbitCard?rabbitUser=$rabbitUserName&amount=${amount.toStringAsFixed(1)}',
  ));
  if (response.statusCode == 200) {
    return true;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return false;
  }
}

Future<bool> topUpRabbitCardByAtm(
  String rabbitUserName,
  double amount,
  String atmNumber,
  String atmPin, {
  required context,
}) async {
  if (kIsMockup) {
    return true;
  }
  final response = await http.post(
      Uri.parse(
        '$kRabbitControllerUrl/getBankApi',
      ),
      headers: {"Content-Type": "application/json"},
      body: json.encode(
          {'amount': amount, 'accountAtmNumber': atmNumber, 'pin': atmPin}));
  if (response.statusCode == 200) {
    return await topUpRabbitCard(rabbitUserName, amount, context: context);
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body, isPop: false);
    return false;
  }
}
