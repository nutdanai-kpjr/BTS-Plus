import 'package:bts_plus/components/buttons/layout/primary_button.dart';
import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/cards/layout/primary_card.dart';
import 'package:bts_plus/components/diaglogs/ticket_detail_dialog.dart';
import 'package:bts_plus/domains/ticket.dart';
import 'package:bts_plus/providers/station_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';

class TicketCard extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    stationIdToDisplayName(stationId) {
      return ref
          .read(stationProvider.notifier)
          .stationIdToDisplayName(stationId);
    }

    return InkWell(
      onTap: () {
        showTicketDetailDialog(
          context,
          ticket: ticket,
          displayFrom: stationIdToDisplayName(ticket.fromStationId),
          displayTo: stationIdToDisplayName(ticket.toStationId),
        );
      },
      child: PrimaryCard(
          height: kHeight(context) * 0.22,
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(bottom: kHeight(context) * 0.01),
                  width: double.infinity,
                  child: Text(
                    'Ticket No. ${ticket.ticketNumber}',
                    style: kBody3TextStyle,
                  )),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  const Expanded(
                    child: Text(
                      'From ',
                      style: kHeader4TextStyle,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(stationIdToDisplayName(ticket.fromStationId),
                        style: kBodyTextStyle),
                  ),
                ]),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  const Expanded(
                    child: Text(
                      'To ',
                      style: kHeader4TextStyle,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(stationIdToDisplayName(ticket.toStationId),
                        style: kBodyTextStyle),
                  ),
                ]),
              ),
              Container(
                margin: EdgeInsets.only(top: kHeight(context) * 0.01),
                height: kHeight(context) * 0.05,
                width: kWidth(context) * 0.5,
                child: PrimaryButton(
                  text: 'Use',
                  onPressed: () {
                    showTicketDetailDialog(
                      context,
                      ticket: ticket,
                      displayFrom: stationIdToDisplayName(ticket.fromStationId),
                      displayTo: stationIdToDisplayName(ticket.toStationId),
                    );
                  },
                ),
              )
              // Expanded(
              // flex: 3,
              // child: Row(
              //   children: [
              //     Expanded(
              //       child: Column(
              //         children: [
              //           const SizedBox(
              //             width: double.infinity,
              //             child: Text(
              //               'From',
              //               style: kHeader5TextStyle,
              //             ),
              //           ),
              //           SizedBox(height: kHeight(context) * 0.015),
              //           Text(stationIdToDisplayName(ticket.fromStationId),
              //               style: kBodyTextStyle),
              //         ],
              //       ),
              //     ),
              //     Expanded(
              //         child: Column(
              //       children: [
              //         const SizedBox(
              //           width: double.infinity,
              //           child: Text(
              //             'To',
              //             style: kHeader5TextStyle,
              //           ),
              //         ),
              //         SizedBox(height: kHeight(context) * 0.015),
              //         Text(stationIdToDisplayName(ticket.toStationId),
              //             style: kBodyTextStyle)
              //       ],
              //     )),
              //     Expanded(
              //       child: PrimaryButton(
              //         text: 'Use',
              //         onPressed: () {
              //           showTicketDetailDialog(context, ticket: ticket);
              //         },
              //       ),
              //     )
              //   ],
              // ))
            ],
          )),
    );
  }
}
