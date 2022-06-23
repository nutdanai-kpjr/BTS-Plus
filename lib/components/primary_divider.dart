import 'package:bts_plus/constants.dart';
import 'package:flutter/material.dart';

class PrimaryDivider extends StatelessWidget {
  const PrimaryDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: kBorderColor,
      thickness: 1,
      height: kHeight(context) * 0.05,
    );
  }
}
