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
      color: kBTSThemeColor,
      height: kHeight(context) * 0.1,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          const Align(
            alignment: Alignment.topLeft,
            child: BackNavigatorButton(),
          ),
          Text(
            title,
            style: kHeader2TextStyle.copyWith(
                color: kThemeFontColor, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
