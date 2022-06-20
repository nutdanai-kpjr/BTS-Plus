// Rounded Corner ListItem
import 'package:flutter/material.dart';

import '../../../constants.dart';

class PrimaryCard extends StatelessWidget {
  const PrimaryCard({
    required this.child,
    Key? key,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(kHeight(context) * 0.0075),
        padding: EdgeInsets.all(kHeight(context) * 0.0025),
        height: kHeight(context) * 0.075,
        decoration: BoxDecoration(
          border: Border.all(color: kBorderColor, width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: child);
  }
}
