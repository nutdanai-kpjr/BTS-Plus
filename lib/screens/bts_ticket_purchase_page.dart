import 'package:bts_plus/components/buttons/layout/quantity_selector_button.dart';
import 'package:bts_plus/components/headers/secondary_header.dart';
import 'package:bts_plus/components/primary_circular_progress_indicator.dart';
import 'package:bts_plus/components/primary_divider.dart';
import 'package:bts_plus/components/primary_scaffold.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/domains/ticket_transcation.dart';
import 'package:bts_plus/domains/user.dart';
import 'package:bts_plus/screens/main_page.dart';
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
      required this.fromStationId,
      required this.toStationId,
      this.quantity = 1})
      : super(key: key);
  final String fromStationId;
  final String toStationId;
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

  onConfirm() async {
    await getTicketTransaction(
      ticketTransaction,
      context: context,
    );

    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => MainPage()));
  }

  @override
  Widget build(BuildContext context) {
    ticketTransaction = TicketTransaction(
        userId: ref.watch(authProvider)!.id!,
        from: widget.fromStationId,
        to: widget.toStationId,
        quantity: widget.quantity);
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
                  BTSPaymentSection(
                    ticketTransaction: ticketTransaction,
                  )
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
    _getTicketTransactionWithPrice = getTicketTransaction(
      ticketTransaction,
      context: context,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    child: const Text('Pricing', style: kHeader3TextStyle)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Sub-Total', style: kBodyTextStyle),
                    Text('฿ ${ticketTransactionWithPrice?.totalPrice ?? '0'}',
                        style: kBodyTextStyle),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: kBodyTextStyle.copyWith(color: kGreen),
                    ),
                    Text('-฿ ${ticketTransactionWithPrice?.discount ?? '0'}',
                        style: kBodyTextStyle.copyWith(color: kGreen)),
                  ],
                ),
                const PrimaryDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: kHeader3TextStyle),
                    Text('฿ ${ticketTransactionWithPrice?.finalPrice ?? '0'}',
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
}
