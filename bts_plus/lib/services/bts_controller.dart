import 'dart:convert';
import 'dart:developer';

import 'package:bts_plus/domains/ticket_transcation.dart';
import 'package:bts_plus/services/rabbit_controller.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../domains/station.dart';
import '../domains/ticket.dart';
import '../domains/user.dart';
import 'base_controller.dart';

const String kBTSControllerUrl = "$kRabbitBasedURL/api/v1/btsCustomer";
const String kInternalBTSControllerUrl = "$kRabbitBasedURL/api/v1/internal";
Future<User?> addUser(User user, {required context}) async {
  final response = await http.post(
      Uri.parse(
        '$kBTSControllerUrl/registerBtsCustomer',
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
    final mockUpRespond =
        await rootBundle.loadString('$kRabbitMockupURL/get_user.json');
    var parsedJson = jsonDecode(mockUpRespond);
    User user =
        User.fromJson(parsedJson, userName: userName, password: password);
    String? rabbitNumber = parsedJson['rabbitNumber'];

    if (rabbitNumber != null) {
      user.rabbitCard = await getRabbitCard(rabbitNumber, context: context);
    }
    return user;
  }

  final response = await http.get(Uri.parse(
    '$kBTSControllerUrl/getBtsCustomer?customerUser=$userName&customerPassword=$password',
  ));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    User user =
        User.fromJson(parsedJson, userName: userName, password: password);
    String? rabbitNumber = parsedJson['rabbitNumber'];
    if (rabbitNumber != null) {
      user.rabbitCard = await getRabbitCard(rabbitNumber, context: context);
    }
    return user;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return null;
    // }
    // }
  }
}

Future<List<Station>> getStations({required context}) async {
  if (kIsMockup) {
    final mockUpRespond =
        await rootBundle.loadString('$kRabbitMockupURL/get_bts_station.json');
    var parsedJson = jsonDecode(mockUpRespond);
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

Future<List<Ticket>> getAvaliableTickets(String userId,
    {required context}) async {
  if (kIsMockup) {
    final mockUpRespond =
        await rootBundle.loadString('$kRabbitMockupURL/get_bts_station.json');
    var parsedJson = jsonDecode(mockUpRespond);
    List<Ticket> tickets =
        parsedJson.map<Ticket>((json) => Ticket.fromJson(json)).toList();
    return tickets;
  }
  final response = await http.get(Uri.parse(
    '$kBTSControllerUrl/getTickets?customerID=$userId',
  ));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    List<Ticket> tickets =
        parsedJson.map<Ticket>((json) => Ticket.fromJson(json)).toList();
    tickets = tickets
        .where((ticket) =>
            ticket.expireDate.isAfter(DateTime.now()) &&
            ticket.status == 'ACTIVE')
        .toList();
    return tickets;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return [];
    // }
    // }
  }
}

Future<bool> processTicketPayment(TicketTransaction ticketTransaction,
    {required context}) async {
  if (kIsMockup) {
    return true;
  }

  final response = await http.post(
    Uri.parse(
      '$kBTSControllerUrl/buyBtsTricket?customerID=${ticketTransaction.userId}&startStation=${ticketTransaction.from}&endStation=${ticketTransaction.to}&totalPrice=${ticketTransaction.totalPrice}&finalPrice=${ticketTransaction.finalPrice}&rabbitShopNumber=${ticketTransaction.shopNumber}&numberOfTicket=${ticketTransaction.quantity}',
    ),
  );
  // final response = await http.post(
  //   Uri.parse(
  //     '$kBTSControllerUrl/buyBtsTricket?customerID=zeU9oYEBukIohEcR0L9L&startStation=S001&endStation=S006&totalPrice=33.0&finalPrice=23.1&rabbitShopNumber=8756244825&numberOfTicket=1',
  //   ),
  // );

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

Future<TicketTransaction> getTicketTransaction(
  TicketTransaction ticketTransaction, {
  required context,
}) async {
  // if (kIsMockup) {
  //   final mockUpRespond =
  //       await rootBundle.loadString('$kRabbitMockupURL/get_bts_price.json');
  //   var parsedJson = jsonDecode(mockUpRespond);
  //   TicketTransaction ticketTransactionWithPrice =
  //       TicketTransaction.fromJsonByUpdatePrice(parsedJson,
  //           userId: ticketTransaction.userId,
  //           from: ticketTransaction.from,
  //           to: ticketTransaction.to);

  //   return ticketTransactionWithPrice;
  // }

  final response = await http.post(
      Uri.parse(
        '$kBTSControllerUrl/calTricket',
      ),
      headers: {"Content-Type": "application/json"},
      body: json.encode(ticketTransaction.toJson()));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    TicketTransaction ticketTransactionWithPrice =
        TicketTransaction.fromJsonByUpdatePrice(parsedJson,
            userId: ticketTransaction.userId,
            from: ticketTransaction.from,
            to: ticketTransaction.to);
    return ticketTransactionWithPrice;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return ticketTransaction;
  }
}
