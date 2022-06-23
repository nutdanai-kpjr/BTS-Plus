import 'package:bts_plus/components/buttons/layout/quantity_selector_button.dart';
import 'package:bts_plus/components/headers/secondary_header.dart';
import 'package:bts_plus/components/primary_circular_progress_indicator.dart';
import 'package:bts_plus/components/primary_divider.dart';
import 'package:bts_plus/components/primary_scaffold.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/domains/ticket_transcation.dart';
import 'package:bts_plus/domains/user.dart';
import 'package:bts_plus/services/btsController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/buttons/layout/primary_button.dart';
import '../components/cards/balance_card.dart';
import '../components/forms/station_selector.dart';
import '../providers/auth_provider.dart';

class BTSTicketPurchasePage extends ConsumerStatefulWidget {
  const BTSTicketPurchasePage(
      {Key? key, required this.from, required this.to, this.quantity = 1})
      : super(key: key);
  final String from;
  final String to;
  final int quantity;

  @override
  BTSTicketPurchasePageState createState() => BTSTicketPurchasePageState();
}

class BTSTicketPurchasePageState extends ConsumerState<BTSTicketPurchasePage> {
  late TicketTransaction ticketTransaction;
  late int quantity = widget.quantity;

  @override
  void initState() {
    super.initState();
    ref.read(authProvider);
  }

  onFromChanged(String value) {
    setState(() {
      ticketTransaction.from = value;
    });
  }

  onToChanged(String value) {
    setState(() {
      ticketTransaction.to = value;
    });
  }

  onQuantityChange(int value) {
    setState(() {
      ticketTransaction.quantity = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    ticketTransaction = TicketTransaction(
        userId: ref.watch(authProvider)!.id!,
        from: widget.from,
        to: widget.to,
        quantity: widget.quantity);
    return PrimaryScaffold(
        bottomNavigationBar: PrimaryButton(
          text: 'Confirm',
          onPressed: () async {
            await getTicketTransaction(ticketTransaction,
                context: context, mockUp: true);
          },
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          const SecondaryHeader(
            title: 'Purchasing Ticket',
          ),
          TicketOptionSection(
            onFromChanged: onFromChanged,
            onToChanged: onToChanged,
            onQuantityChanged: onQuantityChange,
            quantity: quantity,
            from: ticketTransaction.from,
            to: ticketTransaction.to,
          ),
          BTSPaymentSection(
            ticketTransaction: ticketTransaction,
          )
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
  late final String from = widget.from;
  late final String to = widget.to;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          StationSelector(
            onFromChanged: onFromchanged,
            onToChanged: onToChanged,
            from: from,
            to: to,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Number of Ticket',
                style: kHeader3TextStyle,
              ),
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

class BTSPaymentSection extends StatefulWidget {
  const BTSPaymentSection({Key? key, required this.ticketTransaction})
      : super(key: key);
  final TicketTransaction ticketTransaction;
  @override
  State<BTSPaymentSection> createState() => _BTSPaymentSectionState();
}

class _BTSPaymentSectionState extends State<BTSPaymentSection> {
  late TicketTransaction ticketTransaction = widget.ticketTransaction;
  late Future<TicketTransaction> _getTicketTransactionWithPrice;
  @override
  void initState() {
    _getTicketTransactionWithPrice =
        getTicketTransaction(ticketTransaction, context: context, mockUp: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getTicketTransactionWithPrice,
        builder: (context, AsyncSnapshot<TicketTransaction> snapshot) {
          if (snapshot.hasData) {
            var ticketTransactionWithPrice = snapshot.data;

            return Container(
              child: Column(
                children: <Widget>[
                  Text('Pricing'),
                  Row(
                    children: [
                      Text('Sub-Total'),
                      Text('${ticketTransactionWithPrice?.totalPrice ?? '0'}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Discount'),
                      Text('${ticketTransactionWithPrice?.discount ?? '0'}'),
                    ],
                  ),
                  PrimaryDivider(),
                  Row(
                    children: [
                      Text('Total'),
                      Text('Discount'),
                      Text('${ticketTransactionWithPrice?.finalPrice ?? '0'}'),
                    ],
                  ),
                  BalanceCard(
                    balance: 0.0,
                  )
                ],
              ),
            );
          } else {
            return PrimaryCircularProgressIndicator();
          }
        });
  }
}
