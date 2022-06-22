import 'dart:convert';

import 'package:bts_plus/domains/rabbit_card.dart';
import 'package:http/http.dart' as http;

import 'baseController.dart';

const String krabbitControllerUrl = "$kRabbitBasedURL/api/v1/rabbitCard";

Future<bool> addRabbitCard(RabbitCard newRabbitCard, {required context}) async {
  final response = await http.post(
      Uri.parse(
        '$krabbitControllerUrl/registerRabbitCard',
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


// RESTAURANT
// rabbitID: SHOP222222
// rabbitPass: 1111
