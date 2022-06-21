import 'package:bts_plus/components/buttons/layout/primary_button.dart';
import 'package:bts_plus/components/forms/station_selector.dart';
import 'package:bts_plus/components/headers/primary_header.dart';
import 'package:bts_plus/components/primary_scaffold.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/screens/bts_ticket_purchase_page.dart';
import 'package:flutter/material.dart';

import '../components/buttons/layout/buttom_navigator_buttons.dart';
import '../components/cards/balance_card.dart';

class BTSHomeNavPage extends StatelessWidget {
  const BTSHomeNavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      BTSHomeHeader(),
      StationSelector(),
      PrimaryButton(
        text: 'Continue',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BTSTicketPurchasePage()));
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
        children: <Widget>[Text('Availiable Tickets'), Text('Ticket card')],
      ),
    );
  }
}
