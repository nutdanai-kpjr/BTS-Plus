import 'dart:convert';
import 'dart:developer';

import 'package:bts_plus/domains/rabbit_card.dart';
import 'package:bts_plus/services/rabbitController.dart';
import 'package:http/http.dart' as http;

import '../domains/user.dart';
import 'baseController.dart';

const String kBTSControllerUrl = "$kRabbitBasedURL/api/v1/btsCustomer";

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
  final response = await http.get(Uri.parse(
    '$kBTSControllerUrl/getBtsCustomer?customerUser=$userName&customerPassword=$password',
  ));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    User user =
        User.fromJson(parsedJson, userName: userName, password: password);
    String? rabbitNumber = parsedJson['rabbitNumber'];
    log('message: $rabbitNumber');
    if (rabbitNumber != null) {
      user.rabbitCard = await getRabbitCard(rabbitNumber, context: context);
      log(user.rabbitCard?.cardNumber ?? 'notfound');
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
