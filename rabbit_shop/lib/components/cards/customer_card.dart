import 'package:rabbit_shop/components/cards/layout/primary_card.dart';
import 'package:rabbit_shop/constants.dart';
import 'package:rabbit_shop/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils.dart';

class CustomerCard extends ConsumerWidget {
  const CustomerCard({
    Key? key,
  }) : super(key: key);

  //REFRACT
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
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
                    const Text('Shop Name', style: kBody2TextStyle),
                    Container(
                      margin: EdgeInsets.only(top: kHeight(context) * 0.005),
                      child: Text(
                        '${user!.shopName}',
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
                    const Text('Shope Type', style: kBody2TextStyle),
                    Container(
                      margin: EdgeInsets.only(top: kHeight(context) * 0.005),
                      child: Text(
                        '${user.displayShopType}',
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
                      '฿ ${user.shopBalance?.toStringAsFixed(2) ?? '0.00'}',
                      style: kHeader2TextStyle,
                    ),
                  ]),
            ),
          ],
        )
      ]),
    ));
  }
}
