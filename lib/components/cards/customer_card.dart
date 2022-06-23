import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/buttons/topup_button.dart';
import 'package:bts_plus/components/cards/layout/primary_card.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerCard extends ConsumerWidget {
  const CustomerCard(
      {Key? key, required this.balance, required this.name, required this.type})
      : super(key: key);
  final double balance;
  final String name;
  final String type;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    return PrimaryCard(
        child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Name', style: kBody2TextStyle),
                Text(
                  '${user!.fullName}',
                  style: kHeader2TextStyle,
                ),
              ]),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Type', style: kBody2TextStyle),
                Text(
                  '฿ $balance',
                  style: kHeader2TextStyle,
                ),
              ]),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Card Balance', style: kBody2TextStyle),
                Text(
                  '฿ $balance',
                  style: kHeader2TextStyle,
                ),
              ]),
          SizedBox(
              height: kHeight(context) * 0.05,
              width: kWidth(context) * 0.4,
              child: const TopUpButton())
        ],
      )
    ]));
  }
}
