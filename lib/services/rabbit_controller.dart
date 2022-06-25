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
  final response = await http.post(
      Uri.parse(
        '$kRabbitControllerUrl/registerRabbitCardByBts',
      ),
      headers: {"Content-Type": "application/json"},
      body: json.encode(newRabbitCard.toJson()));
  log('ADDING NEW RABBIT CARD USER:');
  log(json.encode(newRabbitCard.toJson()));
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
    final mockUpRespond =
        await rootBundle.loadString('$kRabbitMockupURL/get_rabbit_card.json');
    var parsedJson = jsonDecode(mockUpRespond);
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
    log('RabbitCard: $parsedJson');
    RabbitCard rabbitCard =
        RabbitCard.fromJson(parsedJson, cardNumber: rabbitNumber);
    return rabbitCard;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return null;
  }
}

Future<bool> payByRabbitCard(
  RabbitCard rabbitCard, {
  required context,
}) async {
  log('payByRabbitCard: ${rabbitCard.cardNumber}');
  return true;
}

Future<List<RabbitTransaction>> getRabbitTransactions(rabbitCardNumber,
    {required context}) async {
  log('Hi get RabbitTransaction');

  if (kIsMockup) {
    final mockUpRespond = await rootBundle
        .loadString('$kRabbitMockupURL/get_rabbit_transactions.json');
    var parsedJson = jsonDecode(mockUpRespond);
    List<RabbitTransaction> rabbitTransactions = parsedJson
        .map<RabbitTransaction>((json) => RabbitTransaction.fromJson(json))
        .toList();
    return rabbitTransactions;
  }
  final response = await http.get(Uri.parse(
    '$kRabbitControllerUrl/transcationRabbitCard?rabbitID=$rabbitCardNumber',
  ));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    List<RabbitTransaction> rabbitTransactions = parsedJson
        .map<RabbitTransaction>((json) => RabbitTransaction.fromJson(json))
        .toList();
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
  log('$kInternalBTSControllerUrl/topRabbitCard?rabbitUser=$rabbitUserName&amount=${amount.toStringAsFixed(1)}');
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
