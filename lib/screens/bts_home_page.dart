import 'dart:developer';

import 'package:bts_plus/components/buttons/layout/primary_button.dart';
import 'package:bts_plus/components/cards/ticket_card.dart';
import 'package:bts_plus/components/forms/station_selector.dart';
import 'package:bts_plus/components/headers/primary_header.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/screens/bts_ticket_purchase_page.dart';
import 'package:flutter/material.dart';

import '../components/cards/balance_card.dart';

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
      BTSHomeHeader(),
      StationSelector(onFromChanged: onFromChanged, onToChanged: onToChanged),
      PrimaryButton(
        text: 'Continue',
        onPressed: () {
          log('from: $from, to: $to');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BTSTicketPurchasePage(
                        from: from,
                        to: to,
                      )));
        },
      ),
      AvailiableTicketSection()
    ]));
  }
}

class BTSHomeHeader extends StatelessWidget {
  const BTSHomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryHeader(
        title: 'Home',
        height: kHeight(context) * .2,
        card: BalanceCard(balance: 0.0));
  }
}

class AvailiableTicketSection extends StatelessWidget {
  const AvailiableTicketSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text('Availiable Tickets'),
          TicketCard(from: 'Asok', to: 'Siam')
        ],
      ),
    );
  }
}
