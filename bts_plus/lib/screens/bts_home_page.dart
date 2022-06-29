import 'dart:developer';

import 'package:bts_plus/components/buttons/layout/primary_button.dart';
import 'package:bts_plus/components/cards/no_rabbit_card.dart';
import 'package:bts_plus/components/cards/ticket_card.dart';
import 'package:bts_plus/components/forms/station_selector.dart';
import 'package:bts_plus/components/headers/primary_header.dart';
import 'package:bts_plus/components/require_rabbit_registration_message.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/providers/station_provider.dart';
import 'package:bts_plus/screens/bts_ticket_purchase_page.dart';
import 'package:bts_plus/services/bts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/cards/balance_card.dart';
import '../components/primary_circular_progress_indicator.dart';
import '../domains/ticket.dart';
import '../providers/auth_provider.dart';
import '../services/rabbit_controller.dart';

class BTSHomeNavPage extends ConsumerStatefulWidget {
  const BTSHomeNavPage({Key? key}) : super(key: key);

  @override
  BTSHomeNavPageState createState() => BTSHomeNavPageState();
}

class BTSHomeNavPageState extends ConsumerState<BTSHomeNavPage> {
  String fromStationId = 'S001';
  String toStationId = 'S002';

  @override
  void initState() {
    super.initState();
    ref.read(authProvider);
    ref.read(stationProvider);
    ref.read(stationProvider.notifier).getStationLists(context);
  }

  onFromChanged(String value) {
    setState(() {
      fromStationId = value;
    });
  }

  onToChanged(String value) {
    setState(() {
      toStationId = value;
    });
  }

  bool stationIsValid() {
    return fromStationId != toStationId;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      const BTSHomeHeader(),
      ref.watch(authProvider)!.rabbitCard != null
          ? Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: kWidth(context) * 0.09,
                        vertical: kHeight(context) * 0.025),
                    color: kThemeFontColor,
                    child: Column(
                      children: [
                        StationSelector(
                            onFromChanged: onFromChanged,
                            onToChanged: onToChanged),
                        Container(
                          margin: EdgeInsets.only(
                            top: kHeight(context) * 0.025,
                          ),
                          width: kWidth(context) * 0.5,
                          child: stationIsValid()
                              ? PrimaryButton(
                                  text: 'Continue',
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BTSTicketPurchasePage(
                                                  userId: ref
                                                      .watch(authProvider)!
                                                      .id!,
                                                  fromStationId: fromStationId,
                                                  toStationId: toStationId,
                                                )));
                                  },
                                )
                              : Text(
                                  'Invalid Station',
                                  style: kBodyTextStyle.copyWith(
                                    color: Colors.red,
                                  ),
                                ),
                        ),
                      ],
                    )),
                _AvailiableTicketSection(
                  userId: ref.watch(authProvider)?.id ?? '',
                ),
              ],
            )
          : const RequireRabbitRegistrationMessage()
    ]));
  }
}

class BTSHomeHeader extends ConsumerWidget {
  const BTSHomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rabbitCard = ref.watch(authProvider)?.rabbitCard;
    return PrimaryHeader(
        title: 'My Ticket',
        height: kHeight(context) * (rabbitCard != null ? 0.25 : 0.2),
        card: rabbitCard == null
            ? const NoRabbitCard()
            : const BalanceCard(balance: 0.0));
  }
}

class _AvailiableTicketSection extends StatefulWidget {
  const _AvailiableTicketSection({Key? key, required this.userId})
      : super(key: key);
  final String userId;
  @override
  State<_AvailiableTicketSection> createState() =>
      _AvailiableTicketSectionState();
}

class _AvailiableTicketSectionState extends State<_AvailiableTicketSection> {
  late Future<List<Ticket>> _getTickets;
  @override
  void initState() {
    _getTickets = getAvaliableTickets(widget.userId, context: context);
    super.initState();
  }

  refresh() {
    // log('refresh test');
    setState(() {
      _getTickets = getAvaliableTickets(widget.userId, context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kWidth(context) * 0.05,
          vertical: kHeight(context) * 0.02),
      color: kThemeSecondaryBackgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(kHeight(context) * .006),
            width: double.infinity,
            child: const Text(
              'Available Tickets',
              textAlign: TextAlign.start,
              style: kHeader3TextStyle,
            ),
          ),
          FutureBuilder(
              future: _getTickets,
              builder: (context, AsyncSnapshot<List<Ticket>> snapshot) {
                log(snapshot.toString());
                if (snapshot.hasData) {
                  var tickets = snapshot.data ?? [];
                  tickets = tickets.reversed.toList();
                  return Column(
                    children: [
                      for (var ticket in tickets)
                        TicketCard(
                          ticket: ticket,
                          onPop: refresh,
                        )
                    ],
                  );
                } else {
                  return const PrimaryCircularProgressIndicator();
                }
              })
        ],
      ),
    );
  }
}
