import 'package:rabbit_shop/constants.dart';
import 'package:flutter/material.dart';

class PrimaryDivider extends StatelessWidget {
  const PrimaryDivider({Key? key, this.indent, this.thickness, this.endIndent})
      : super(key: key);
  final double? indent;
  final double? thickness;
  final double? endIndent;
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: kBorderColor,
      thickness: 1,
      height: kHeight(context) * 0.05,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
