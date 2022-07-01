import 'package:bts_plus/components/buttons/topup_button.dart';
import 'package:bts_plus/components/cards/layout/primary_card.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/providers/auth_provider.dart';
import 'package:bts_plus/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerCard extends ConsumerWidget {
  const CustomerCard({
    Key? key,
  }) : super(key: key);

  //REFRACT
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(authProvider);
    return PrimaryCard(
        child: Container(
      margin: EdgeInsets.all(kWidth(context) * 0.02),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          children: [
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Name', style: kBody2TextStyle),
                    Container(
                      margin: EdgeInsets.only(top: kHeight(context) * 0.005),
                      child: Text(
                        '${user!.fullName}',
                        style: kHeader3TextStyle,
                      ),
                    ),
                  ]),
            ),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Type', style: kBody2TextStyle),
                    Container(
                      margin: EdgeInsets.only(top: kHeight(context) * 0.005),
                      child: Text(
                        '${getCapitalized(user.rabbitCard?.type ?? 'Unknown')}',
                        style: kHeader3TextStyle,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
        SizedBox(
          height: kHeight(context) * 0.02,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Card Balance', style: kBody2TextStyle),
                    Text(
                      '฿ ${user.rabbitCard?.balanceWithCommas ?? '0.00'}',
                      style: (user.rabbitCard?.balance
                                  .toStringAsFixed(2)
                                  .length)! >=
                              8
                          ? kHeader3TextStyle
                          : kHeader4TextStyle,
                    ),
                  ]),
            ),
            Expanded(
              child: SizedBox(
                  height: kHeight(context) * 0.05,
                  width: kWidth(context) * 0.4,
                  child: const TopUpButton(
                    color: kRabbitThemeColor,
                  )),
            )
          ],
        )
      ]),
    ));
  }
}
