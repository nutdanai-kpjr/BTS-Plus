import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/cards/layout/primary_card.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({Key? key, required this.from, required this.to})
      : super(key: key);
  final String from;
  final String to;
  // final Datetime date;
  // final String buyer;
  // final int stationDistance;
  // final double price;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
        child: Column(
      children: [
        Expanded(flex: 1, child: Text('TicketID')),
        Expanded(
            flex: 4,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [Text('From'), Text(from)],
                  ),
                ),
                Expanded(
                    child: Row(
                  children: [Text('To'), Text(to)],
                )),
                Expanded(child: SecondaryButton(text: 'Use'))
              ],
            ))
      ],
    ));
  }
}
