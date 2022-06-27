import 'package:rabbit_shop/components/buttons/layout/back_navigator_button.dart';
import 'package:rabbit_shop/constants.dart';
import 'package:flutter/material.dart';

class SecondaryHeader extends StatelessWidget {
  const SecondaryHeader({
    Key? key,
    required this.title,
    this.color = kThemeColor,
  }) : super(key: key);
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        // border: Border.all(color: kBorderColor, width: 2.0),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.5),
            bottomRight: Radius.circular(12.5)),
      ),
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
