import 'package:bts_plus/components/buttons/layout/quantity_selector_button.dart';
import 'package:bts_plus/components/headers/secondary_header.dart';
import 'package:bts_plus/components/primary_divider.dart';
import 'package:bts_plus/components/primary_scaffold.dart';
import 'package:bts_plus/screens/bts_home_page.dart';
import 'package:flutter/material.dart';

import '../components/buttons/layout/buttom_navigator_buttons.dart';
import '../components/buttons/layout/primary_button.dart';
import '../components/cards/balance_card.dart';
import '../components/forms/station_selector.dart';

class BTSTicketPurchasePage extends StatelessWidget {
  const BTSTicketPurchasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        bottomNavigationBar: PrimaryButton(
          text: 'Confirm',
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          SecondaryHeader(
            title: 'Purchasing Ticket',
          ),
          TicketOptionSection(),
          PaymentSection()
        ])));
  }
}

class TicketOptionSection extends StatelessWidget {
  const TicketOptionSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          StationSelector(),
          Row(
            children: [
              Text('Number of Ticket'),
              QuantitySelector(),
            ],
          ),
          PrimaryDivider()
        ],
      ),
    );
  }
}

class PaymentSection extends StatelessWidget {
  const PaymentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text('Pricing'),
          Row(
            children: [
              Text('Sub-Total'),
              Text('0.0'),
            ],
          ),
          Row(
            children: [
              Text('Discount'),
              Text('0.0'),
            ],
          ),
          PrimaryDivider(),
          Row(
            children: [
              Text('Total'),
              Text('0.0'),
            ],
          ),
          BalanceCard(
            balance: 0.0,
          )
        ],
      ),
    );
  }
}
