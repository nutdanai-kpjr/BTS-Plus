import 'package:bts_plus/components/cards/customer_card.dart';
import 'package:bts_plus/components/cards/layout/primary_card.dart';
import 'package:bts_plus/components/cards/no_rabbit_card.dart';
import 'package:bts_plus/components/forms/rabbit_registration_form.dart';
import 'package:bts_plus/domains/rabbit_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/cards/transaction_card.dart';
import '../components/headers/primary_header.dart';
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
          !haveRabbitCard ? TransactionSection() : RabbitRegisterSection()
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
        title: 'Rabbit Card',
        height: kHeight(context) * (haveRabbitCard ? 0.3 : 0.2),
        card: haveRabbitCard
            ? CustomerCard(
                balance: 0.0,
                name: 'John Doe',
                type: 'Adult',
              )
            : NoRabbitCard());
  }
}

class TransactionSection extends StatelessWidget {
  const TransactionSection({Key? key}) : super(key: key);

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
              'My Transactions',
              textAlign: TextAlign.start,
              style: kHeader3TextStyle,
            ),
          ),
          for (var i in List.generate(10, (i) => i))
            TransactionCard(
              rabbitTransaction: RabbitTransaction.mockUp(),
            )
        ],
      ),
    );
  }
}

class RabbitRegisterSection extends StatelessWidget {
  const RabbitRegisterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/rabbit_logo.png'),
        const Text('New Rabbit Card'),
        RabbitRegistrationForm(),
      ],
    );
  }
}
