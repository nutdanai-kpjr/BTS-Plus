import 'package:bts_plus/components/buttons/layout/primary_button.dart';
import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/cards/layout/primary_card.dart';
import 'package:bts_plus/components/diaglogs/ticket_detail_dialog.dart';
import 'package:bts_plus/domains/ticket.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({
    Key? key,
    required this.ticket,
  }) : super(key: key);
  final Ticket ticket;
  // final Datetime date;
  // final String buyer;
  // final int stationDistance;
  // final double price;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showTicketDetailDialog(context, ticket: ticket);
      },
      child: PrimaryCard(
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
                            Text(ticket.fromStationId, style: kBodyTextStyle)
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
                          Text(ticket.toStationId, style: kBodyTextStyle)
                        ],
                      )),
                      Expanded(
                        child: PrimaryButton(
                          text: 'Use',
                          onPressed: () {
                            showTicketDetailDialog(context, ticket: ticket);
                          },
                        ),
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}
