import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/cards/layout/primary_card.dart';
import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({Key? key, required this.balance}) : super(key: key);
  final double balance;
  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
        child: Row(
      children: [
        Column(children: [
          Text('Card Balance'),
          Text('$balance'),
        ]),
        SecondaryButton(text: 'Topup +')
      ],
    ));
  }
}
