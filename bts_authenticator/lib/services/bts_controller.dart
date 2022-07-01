import 'dart:convert';
import 'dart:developer';

import 'package:bts_authenticator/services/authenticator_configuration.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../domains/station.dart';
import '../domains/ticket.dart';

import 'base_controller.dart';

const String kBTSControllerUrl = "$kRabbitBasedURL/api/v1/btsCustomer";
const String kInternalBTSControllerUrl = "$kRabbitBasedURL/api/v1/internal";

Future<List<Station>> getStations({required context}) async {
  if (kIsMockup) {
    var parsedJson = await jsonFromMockUpApi('get_bts_station.json');
    List<Station> stations =
        parsedJson.map<Station>((json) => Station.fromJson(json)).toList();
    return stations;
  }

  final response = await http.get(Uri.parse(
    '$kInternalBTSControllerUrl/getAllStation',
  ));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    List<Station> stations =
        parsedJson.map<Station>((json) => Station.fromJson(json)).toList();
    return stations;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return [];
    // }
    // }
  }
}

Future<bool> authorizeTicket(
  Ticket ticket, {
  required desitnationStationId,
  required context,
}) async {
  if (kIsMockup) {
    return true;
  }
  if (AuthenticatorConfiguration().isGateExit ||
      ticket.fromStationId != AuthenticatorConfiguration().gateStationId) {
    return false;
  }
  final response = await http.post(
    Uri.parse(
      '$kBTSControllerUrl/checkInTricket?tricketNumber=${ticket.ticketNumber}&startStation=${AuthenticatorConfiguration().gateStationId}&endStation=${desitnationStationId}',
    ),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // var parsedJson = jsonDecode(response.body);
    return true;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return false;
  }
}
