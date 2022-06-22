import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/buttons/topup_button.dart';
import 'package:bts_plus/components/cards/layout/primary_card.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({Key? key, required this.balance}) : super(key: key);
  final double balance;
  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Card Balance', style: kBody2TextStyle),
              Text(
                '฿ $balance',
                style: kHeader2TextStyle,
              ),
            ]),
        SizedBox(
            height: kHeight(context) * 0.05,
            width: kWidth(context) * 0.4,
            child: const TopUpButton())
      ],
    ));
  }
}
