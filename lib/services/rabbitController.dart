import 'dart:convert';
import 'dart:developer';

import 'package:bts_plus/domains/rabbit_card.dart';
import 'package:http/http.dart' as http;

import 'baseController.dart';

const String kRabbitControllerUrl = "$kRabbitBasedURL/api/v1/rabbitCard";
//TODO Fix Bool to RabbitCard?
Future<bool> addRabbitCard(
  RabbitCard newRabbitCard, {
  required context,
}) async {
  log('addRabbitCard: ${newRabbitCard.btsUserId}');
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

Future<RabbitCard?> getRabbitCard(rabbitNumber, {required context}) async {
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
    // }
    // }
  }
}
