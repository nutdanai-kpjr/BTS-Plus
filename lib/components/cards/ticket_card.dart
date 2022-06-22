import 'package:bts_plus/components/buttons/layout/primary_button.dart';
import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/cards/layout/primary_card.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

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
        height: kHeight(context) * 0.12,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(bottom: kHeight(context) * 0.01),
                width: double.infinity,
                child: Text(
                  'TicketID',
                  style: kBody3TextStyle,
                )),
            Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            child: Text(
                              'From',
                              style: kHeader5TextStyle,
                            ),
                          ),
                          SizedBox(width: kWidth(context) * 0.02),
                          Text(from, style: kBodyTextStyle)
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'To',
                            style: kHeader5TextStyle,
                          ),
                        ),
                        SizedBox(width: kWidth(context) * 0.02),
                        Text(to, style: kBodyTextStyle)
                      ],
                    )),
                    Expanded(
                      child: PrimaryButton(
                        text: 'Use',
                        onPressed: () {},
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
