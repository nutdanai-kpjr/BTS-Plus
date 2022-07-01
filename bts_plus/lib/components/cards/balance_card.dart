import 'package:bts_plus/components/buttons/topup_button.dart';
import 'package:bts_plus/components/cards/layout/primary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import '../../providers/auth_provider.dart';

class BalanceCard extends ConsumerWidget {
  const BalanceCard({Key? key, this.height, this.buttonWidth})
      : super(key: key);
  final double? height;
  final double? buttonWidth;
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
                    '฿ ${user?.rabbitCard?.balanceWithCommas ?? '0.00'}',
                    style: (user?.rabbitCard?.balance
                                .toStringAsFixed(2)
                                .length)! >=
                            8
                        ? kHeader3TextStyle
                        : kHeader4TextStyle,
                  ),
                ]),
            SizedBox(
                height: kHeight(context) * 0.05,
                width: buttonWidth ?? kWidth(context) * 0.35,
                child: const TopUpButton())
          ],
        ));
  }
}
