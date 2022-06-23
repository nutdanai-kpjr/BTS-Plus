import 'package:bts_plus/components/buttons/layout/primary_button.dart';
import 'package:bts_plus/constants.dart';
import 'package:flutter/material.dart';

const String kRabbitBasedURL = "http://192.168.86.71:50001/rabbit";
const String kRabbitMockupURL = "assets/json/";

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
              text: "Close",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
