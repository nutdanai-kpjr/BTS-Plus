import 'dart:async';

import 'package:bts_plus/components/buttons/layout/primary_button.dart';
import 'package:bts_plus/constants.dart';
import 'package:flutter/material.dart';

// const String kRabbitBasedURL = "http://192.168.1.42:8082/rabbit-ws";
// const String kRabbitBasedURL = "http://localhost:8082/rabbit";
const String kRabbitBasedURL = "http://10.0.2.2:8082/rabbit-ws";
const String kRabbitMockupURL = "assets/json";
const bool kIsMockup = false;
Future<void> showErrorDialog(context, body) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            body["error"] ?? "Unkown error",
            style: kHeader1TextStyle,
          ),
          content: Text(
            body["message"] ?? 'Something went wrong',
            style: kBodyTextStyle,
          ),
          actions: <Widget>[
            PrimaryButton(
              color: kHeaderFontColor,
              text: "Close",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}