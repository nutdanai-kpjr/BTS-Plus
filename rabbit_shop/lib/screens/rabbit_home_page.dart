import 'dart:developer';

import 'package:rabbit_shop/components/cards/customer_card.dart';
import 'package:rabbit_shop/domains/rabbit_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/cards/transaction_card.dart';
import '../components/headers/primary_header.dart';
import '../components/primary_circular_progress_indicator.dart';
import '../constants.dart';
import '../providers/auth_provider.dart';
import '../services/rabbit_shop_controller.dart';

class RabbitHomeNavPage extends StatelessWidget {
  const RabbitHomeNavPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [RabbitHomeHeader(), TransactionSection()],
      ),
    );
  }
}

class RabbitHomeHeader extends StatelessWidget {
  const RabbitHomeHeader({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PrimaryHeader(
        color: kThemeColor,
        title: 'My Rabbit Card',
        height: kHeight(context) * 0.3,
        card: const CustomerCard());
  }
}

class TransactionSection extends ConsumerWidget {
  const TransactionSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
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
            rabbitShopId: user?.id ?? '',
          )
        ],
      ),
    );
  }
}

class RabbitTransactionList extends StatefulWidget {
  const RabbitTransactionList({
    Key? key,
    required this.rabbitShopId,
  }) : super(key: key);
  final String rabbitShopId;
  @override
  State<RabbitTransactionList> createState() => _RabbitTransactionListState();
}

class _RabbitTransactionListState extends State<RabbitTransactionList> {
  late Future<List<RabbitTransaction>> _getTransactions;
  @override
  void initState() {
    _getTransactions =
        getRabbitTransactions(widget.rabbitShopId, context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getTransactions,
        builder: (context, AsyncSnapshot<List<RabbitTransaction>> snapshot) {
          if (snapshot.hasData) {
            var transactions = snapshot.data ?? [];
            log(transactions.toString());
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
