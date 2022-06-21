import 'package:bts_plus/components/buttons/layout/back_navigator_button.dart';
import 'package:bts_plus/components/cards/balance_card.dart';
import 'package:bts_plus/constants.dart';
import 'package:flutter/material.dart';

class SecondaryHeader extends StatelessWidget {
  const SecondaryHeader({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kThemeColor,
      height: kHeight(context) * 0.15,
      child: Column(
        children: <Widget>[
          Expanded(flex: 1, child: BackNavigatorButton()),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(color: kThemeFontColor),
            ),
          ),
        ],
      ),
    );
  }
}
