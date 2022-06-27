import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/cards/layout/primary_card.dart';
import 'package:bts_plus/components/utils.dart';
import 'package:bts_plus/domains/rabbit_transaction.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../buttons/layout/primary_button.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.rabbitTransaction,
  }) : super(key: key);
  final RabbitTransaction rabbitTransaction;
  // final Datetime date;
  // final String buyer;
  // final int stationDistance;
  // final double price;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
        height: kHeight(context) * 0.08,
        child: Row(
          children: [
            Expanded(
              // flex: 4,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      '${rabbitTransaction.title}',
                      style: kHeader3TextStyle,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: kHeight(context) * 0.0025),
                      width: double.infinity,
                      child: Text(
                          '${getFormatDateWithTime(rabbitTransaction.timeStamp)}',
                          style: kBody3TextStyle)),
                ],
              ),
            ),
            if (!rabbitTransaction.isIncome())
              Text('-฿ ${rabbitTransaction.amount}',
                  style: kHeader3TextStyle.copyWith(color: kRed))
            else
              Text('+฿ ${rabbitTransaction.amount}',
                  style: kHeader3TextStyle.copyWith(color: kGreen)),
          ],
        ));
  }
}
