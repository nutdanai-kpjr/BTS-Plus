import 'package:bts_plus/components/cards/customer_card.dart';
import 'package:bts_plus/components/cards/layout/primary_card.dart';
import 'package:bts_plus/components/cards/no_rabbit_card.dart';
import 'package:bts_plus/components/forms/rabbit_registration_form.dart';
import 'package:bts_plus/components/require_rabbit_registration_message.dart';
import 'package:bts_plus/domains/rabbit_transaction.dart';
import 'package:bts_plus/services/rabbit_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/cards/transaction_card.dart';
import '../components/headers/primary_header.dart';
import '../components/primary_circular_progress_indicator.dart';
import '../constants.dart';
import '../providers/auth_provider.dart';

class RabbitHomeNavPage extends ConsumerWidget {
  const RabbitHomeNavPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rabbitCard = ref.watch(authProvider)?.rabbitCard;
    final bool haveRabbitCard = rabbitCard != null;
    return SingleChildScrollView(
      child: Column(
        children: [
          RabbitHomeHeader(
            haveRabbitCard: haveRabbitCard,
          ),
          haveRabbitCard
              ? const TransactionSection()
              : const RequireRabbitRegistrationMessage()
        ],
      ),
    );
  }
}

class RabbitHomeHeader extends StatelessWidget {
  const RabbitHomeHeader({Key? key, required this.haveRabbitCard})
      : super(key: key);
  final bool haveRabbitCard;
  @override
  Widget build(BuildContext context) {
    return PrimaryHeader(
        color: kRabbitThemeColor,
        title: 'My Rabbit Card',
        height: kHeight(context) * (haveRabbitCard ? 0.35 : 0.2),
        card: haveRabbitCard
            ? const CustomerCard()
            : const NoRabbitCard(
                color: kRabbitThemeColor,
              ));
  }
}

class TransactionSection extends ConsumerWidget {
  const TransactionSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rabbitCard = ref.watch(authProvider)?.rabbitCard;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kWidth(context) * 0.05,
          vertical: kHeight(context) * 0.02),
      // color: kThemeSecondaryBackgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(kHeight(context) * .01),
            width: double.infinity,
            child: const Text(
              'My Transactions',
              textAlign: TextAlign.start,
              style: kHeader3TextStyle,
            ),
          ),
          RabbitTransactionList(
            rabbitId: rabbitCard?.id ?? '',
          )
        ],
      ),
    );
  }
}

class RabbitTransactionList extends StatefulWidget {
  const RabbitTransactionList({
    Key? key,
    required this.rabbitId,
  }) : super(key: key);
  final String rabbitId;
  @override
  State<RabbitTransactionList> createState() => _RabbitTransactionListState();
}

class _RabbitTransactionListState extends State<RabbitTransactionList> {
  late Future<List<RabbitTransaction>> _getTransactions;
  @override
  void initState() {
    _getTransactions = getRabbitTransactions(widget.rabbitId, context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getTransactions,
        builder: (context, AsyncSnapshot<List<RabbitTransaction>> snapshot) {
          if (snapshot.hasData) {
            var transactions = snapshot.data ?? [];
            return Column(
              children: [
                for (var transaction in transactions)
                  TransactionCard(
                    rabbitTransaction: transaction,
                  )
              ],
            );
          } else {
            return const PrimaryCircularProgressIndicator();
          }
        });
  }
}
