import 'package:bts_plus/components/buttons/topup_button.dart';
import 'package:bts_plus/components/cards/layout/primary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import '../../providers/auth_provider.dart';

class BalanceCard extends ConsumerWidget {
  const BalanceCard({Key? key, required this.balance, this.height})
      : super(key: key);
  final double balance;
  final double? height;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(authProvider);
    return PrimaryCard(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Card Balance', style: kBody2TextStyle),
                  Text(
                    '฿ ${user?.rabbitCard?.balance.toStringAsFixed(2) ?? '0.00'}',
                    style: kHeader2TextStyle,
                  ),
                ]),
            SizedBox(
                height: kHeight(context) * 0.05,
                width: kWidth(context) * 0.4,
                child: const TopUpButton())
          ],
        ));
  }
}
