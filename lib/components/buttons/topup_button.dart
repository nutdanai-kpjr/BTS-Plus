import 'dart:developer';

import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/screens/rabbit_topup_page.dart';
import 'package:flutter/material.dart';

class TopUpButton extends StatelessWidget {
  const TopUpButton({
    Key? key,
    this.color = kBTSThemeColor,
  }) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
        color: color,
        text: 'Topup +',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RabbitTopUpPage()));
        });
  }
}
