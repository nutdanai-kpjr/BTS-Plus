import 'dart:developer';

import 'package:bts_plus/components/buttons/layout/quantity_selector_button.dart';
import 'package:bts_plus/components/headers/secondary_header.dart';
import 'package:bts_plus/components/primary_circular_progress_indicator.dart';
import 'package:bts_plus/components/primary_divider.dart';
import 'package:bts_plus/components/primary_scaffold.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/domains/ticket_transcation.dart';
import 'package:bts_plus/services/bts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/buttons/layout/primary_button.dart';
import '../components/cards/balance_card.dart';
import '../components/forms/station_selector.dart';
import '../providers/auth_provider.dart';

class BTSTicketPurchasePage extends ConsumerStatefulWidget {
  const BTSTicketPurchasePage(
      {Key? key,
      required this.userId,
      required this.fromStationId,
      required this.toStationId,
      this.quantity = 1})
      : super(key: key);
  final String fromStationId;
  final String toStationId;
  final int quantity;
  final String userId;

  @override
  BTSTicketPurchasePageState createState() => BTSTicketPurchasePageState();
}

class BTSTicketPurchasePageState extends ConsumerState<BTSTicketPurchasePage> {
  late TicketTransaction ticketTransaction;
  late int quantity = widget.quantity;
  late String userId = widget.userId;
  late Future<TicketTransaction> _getTicketTransactionWithPrice;
  @override
  void initState() {
    super.initState();
    ref.read(authProvider);

    ticketTransaction = TicketTransaction(
        userId: widget.userId,
        from: widget.fromStationId,
        to: widget.toStationId,
        quantity: widget.quantity);
    _getTicketTransactionWithPrice = getTicketTransaction(
      ticketTransaction,
      context: context,
    );
  }

  onFromChanged(String value) async {
    setState(() {
      ticketTransaction.from = value;
    });
    await refreshTicket();
  }

  onToChanged(String value) async {
    setState(() {
      ticketTransaction.to = value;
    });
    await refreshTicket();
  }

  onQuantityChange(int value) async {
    setState(() {
      ticketTransaction.quantity = value;
    });
    await refreshTicket();
  }

  refreshTicket() async {
    setState(() {
      _getTicketTransactionWithPrice = getTicketTransaction(
        ticketTransaction,
        context: context,
      );
    });
  }

  onConfirm() async {
    await getTicketTransaction(
      ticketTransaction,
      context: context,
    );

    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => MainPage()));
  }

  _buildBTSPaymentSection() {
    return FutureBuilder(
        future: _getTicketTransactionWithPrice,
        builder: (context, AsyncSnapshot<TicketTransaction> snapshot) {
          if (snapshot.hasData) {
            var ticketTransactionWithPrice = snapshot.data;

//REFRACT
            return Column(
              children: <Widget>[
                Container(
                    width: double.infinity,
                    margin:
                        EdgeInsets.symmetric(vertical: kHeight(context) * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Ticket Price', style: kHeader3TextStyle),
                        Text(
                            '฿ ${ticketTransactionWithPrice?.pricePerTicket?.toStringAsFixed(2) ?? '0'}',
                            style: kHeader3TextStyle),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Sub-Total', style: kBodyTextStyle),
                    Text(
                        '฿ ${ticketTransactionWithPrice?.totalPrice?.toStringAsFixed(2) ?? '0'}',
                        style: kBodyTextStyle),
                  ],
                ),
                ticketTransactionWithPrice?.discount != 0.0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount',
                            style: kBodyTextStyle.copyWith(color: kGreen),
                          ),
                          Text(
                              '-฿ ${ticketTransactionWithPrice?.discount?.toStringAsFixed(2) ?? '0'}',
                              style: kBodyTextStyle.copyWith(color: kGreen)),
                        ],
                      )
                    : Container(),
                const PrimaryDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: kHeader3TextStyle),
                    Text(
                        '฿ ${ticketTransactionWithPrice?.finalPrice?.toStringAsFixed(2) ?? '0'}',
                        style: kHeader3TextStyle),
                  ],
                ),
                SizedBox(
                  height: kHeight(context) * 0.02,
                ),
                BalanceCard(
                  balance: 0.0,
                  height: kHeight(context) * 0.125,
                )
              ],
            );
          } else {
            return const PrimaryCircularProgressIndicator();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(kWidth(context) * 0.05),
          child: PrimaryButton(
            text: 'Confirm',
            onPressed: onConfirm,
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          const SecondaryHeader(
            title: 'Purchasing Ticket',
          ),
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: kWidth(context) * 0.09,
                  vertical: kHeight(context) * 0.025),
              child: Column(
                children: [
                  TicketOptionSection(
                    onFromChanged: onFromChanged,
                    onToChanged: onToChanged,
                    onQuantityChanged: onQuantityChange,
                    quantity: quantity,
                    from: ticketTransaction.from,
                    to: ticketTransaction.to,
                  ),
                  _buildBTSPaymentSection()
                ],
              ))
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
            fromStationId: from,
            toStationId: to,
          ),
          SizedBox(height: kHeight(context) * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          const PrimaryDivider()
        ],
      ),
    );
  }
}
