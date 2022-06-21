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

class BTSTicketPurchasePage extends StatefulWidget {
  const BTSTicketPurchasePage(
      {Key? key, required this.from, required this.to, this.quantity = 1})
      : super(key: key);
  final String from;
  final String to;
  final int quantity;

  @override
  State<BTSTicketPurchasePage> createState() => _BTSTicketPurchasePageState();
}

class _BTSTicketPurchasePageState extends State<BTSTicketPurchasePage> {
  late String from = widget.from;
  late String to = widget.to;
  late int quantity = widget.quantity;
  onFromChanged(String value) {
    setState(() {
      from = value;
    });
  }

  onToChanged(String value) {
    setState(() {
      to = value;
    });
  }

  onQuantityChange(int value) {
    setState(() {
      quantity = value;
    });
  }

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
          TicketOptionSection(
            onFromChanged: onFromChanged,
            onToChanged: onToChanged,
            onQuantityChanged: onQuantityChange,
            quantity: quantity,
            from: from,
            to: to,
          ),
          PaymentSection()
        ])));
  }
}

class TicketOptionSection extends StatefulWidget {
  const TicketOptionSection(
      {Key? key,
      required this.onFromChanged,
      required this.onToChanged,
      required this.onQuantityChanged,
      required this.quantity,
      required this.from,
      required this.to})
      : super(key: key);
  final Function(String) onFromChanged;
  final Function(String) onToChanged;
  final Function(int) onQuantityChanged;
  final int quantity;
  final String from;
  final String to;
  @override
  State<TicketOptionSection> createState() => _TicketOptionSectionState();
}

class _TicketOptionSectionState extends State<TicketOptionSection> {
  late final Function(String) onFromchanged = widget.onFromChanged;
  late final Function(String) onToChanged = widget.onToChanged;
  late final Function(int) onquantityChanged = widget.onQuantityChanged;
  late final int quantity = widget.quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          StationSelector(
            onFromChanged: onFromchanged,
            onToChanged: onToChanged,
          ),
          Row(
            children: [
              Text('Number of Ticket'),
              QuantitySelector(
                quantity: quantity,
                onChanged: onquantityChanged,
              ),
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
