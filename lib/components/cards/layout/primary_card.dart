// Rounded Corner ListItem
import 'package:flutter/material.dart';

import '../../../constants.dart';

class PrimaryCard extends StatelessWidget {
  const PrimaryCard({
    required this.child,
    Key? key,
    this.height,
    this.margin,
    this.padding,
  }) : super(key: key);
  final Widget child;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin ?? EdgeInsets.all(kHeight(context) * 0.0075),
        padding: padding ?? EdgeInsets.all(kHeight(context) * 0.0025),
        height: height ?? kHeight(context) * 0.075,
        decoration: BoxDecoration(
          color: kThemeFontColor,
          border: Border.all(color: kBorderColor, width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: child);
  }
}
