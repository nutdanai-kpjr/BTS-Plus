import 'dart:convert';
import 'dart:developer';

import 'package:bts_authenticator/services/authenticator_configuration.dart';
import 'package:bts_authenticator/services/bts_controller.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../domains/rabbit_card.dart';

import 'base_controller.dart';

const String kRabbitControllerUrl = "$kRabbitBasedURL/api/v1/rabbitCard";
const kBTSshopNumber = '8278640311';
Future<bool> authorizeRabbitCardEntranceGate(
  RabbitCard rabbitCard, {
  required context,
}) async {
  final String stationId = AuthenticatorConfiguration().gateStationId;

  final response = await http.post(
    Uri.parse(
      '$kRabbitControllerUrl/enterBts?rabbitUser=${rabbitCard.userName}&startStationID=$stationId',
    ),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return false;
  }
}

Future<bool> authorizeRabbitCardExitGate(
  RabbitCard rabbitCard, {
  required context,
}) async {
  final String stationId = AuthenticatorConfiguration().gateStationId;

  final response = await http.post(
    Uri.parse(
      '$kRabbitControllerUrl/exitBts?rabbitUser=${rabbitCard.userName}&endStationID=$stationId&rabbitShopNumber=$kBTSshopNumber',
    ),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return false;
  }
}
