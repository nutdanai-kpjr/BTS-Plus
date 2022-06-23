import 'dart:developer';

import 'package:bts_plus/components/buttons/layout/primary_button.dart';
import 'package:bts_plus/components/cards/no_rabbit_card.dart';
import 'package:bts_plus/components/cards/ticket_card.dart';
import 'package:bts_plus/components/forms/station_selector.dart';
import 'package:bts_plus/components/headers/primary_header.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/screens/bts_ticket_purchase_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/cards/balance_card.dart';
import '../domains/ticket.dart';
import '../providers/auth_provider.dart';

class BTSHomeNavPage extends StatefulWidget {
  const BTSHomeNavPage({Key? key}) : super(key: key);

  @override
  State<BTSHomeNavPage> createState() => _BTSHomeNavPageState();
}

class _BTSHomeNavPageState extends State<BTSHomeNavPage> {
  String from = 'Item 1';
  String to = 'Item 2';
  onFromChanged(String value) {
    setState(() {
      from = value;
    });
    log('onFromChanged: $value');
  }

  onToChanged(String value) {
    setState(() {
      to = value;
    });
    log('onToChanged: $to');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      const BTSHomeHeader(),
      Container(
          margin: EdgeInsets.symmetric(
              horizontal: kWidth(context) * 0.09,
              vertical: kHeight(context) * 0.025),
          color: kThemeFontColor,
          child: Column(
            children: [
              StationSelector(
                  onFromChanged: onFromChanged, onToChanged: onToChanged),
              Container(
                margin: EdgeInsets.only(
                  top: kHeight(context) * 0.025,
                ),
                width: kWidth(context) * 0.5,
                child: PrimaryButton(
                  text: 'Continue',
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BTSTicketPurchasePage(
                                  from: from,
                                  to: to,
                                )));
                  },
                ),
              ),
            ],
          )),
      _AvailiableTicketSection()
    ]));
  }
}

class BTSHomeHeader extends ConsumerWidget {
  const BTSHomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rabbitCard = ref.watch(authProvider)?.rabbitCard;
    return PrimaryHeader(
        title: 'Home',
        height: kHeight(context) * .225,
        card: rabbitCard == null
            ? const NoRabbitCard()
            : const BalanceCard(balance: 0.0));
  }
}

class _AvailiableTicketSection extends StatelessWidget {
  const _AvailiableTicketSection({Key? key}) : super(key: key);

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
            margin: EdgeInsets.all(kHeight(context) * .01),
            width: double.infinity,
            child: const Text(
              'Available Tickets',
              textAlign: TextAlign.start,
              style: kHeader3TextStyle,
            ),
          ),
          for (var i in List.generate(10, (i) => i))
            TicketCard(ticket: Ticket.mockUp())
        ],
      ),
    );
  }
}
