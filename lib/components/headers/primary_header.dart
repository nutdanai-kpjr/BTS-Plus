import 'package:bts_plus/components/cards/balance_card.dart';
import 'package:bts_plus/constants.dart';
import 'package:flutter/material.dart';

class PrimaryHeader extends StatelessWidget {
  const PrimaryHeader(
      {Key? key, required this.title, required this.height, required this.card})
      : super(key: key);
  final String title;
  final double height;
  final Widget card;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kThemeColor,
      height: height,
      child: Column(
        children: <Widget>[
          Expanded(flex: 1, child: Container()),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(color: kThemeFontColor),
            ),
          ),
          Expanded(flex: 3, child: card),
        ],
      ),
    );
  }
}
