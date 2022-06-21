import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/cards/layout/primary_card.dart';
import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard(
      {Key? key, required this.balance, required this.name, required this.type})
      : super(key: key);
  final double balance;
  final String name;
  final String type;
  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
        child: Column(
      children: [
        Row(
          children: [
            Row(
              children: [
                Column(
                  children: [Text('Name'), Text(name)],
                ),
                Column(
                  children: [Text('Type'), Text(type)],
                )
              ],
            ),
            Column(children: [
              Text('Balance'),
              Text('$balance'),
            ]),
            SecondaryButton(text: 'Topup +')
          ],
        ),
      ],
    ));
  }
}
