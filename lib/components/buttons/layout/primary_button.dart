// OutlinedButton

import 'package:flutter/material.dart';

import '../../../constants.dart';


class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key, required this.text, this.onPressed, this.color = kBorderColor})
      : super(key: key);
  final String text;
  final Function()? onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color, width: 2.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          primary: kPrimaryFontColor,
          // backgroundColor: w,
          textStyle: kBodyTextStyle,
        ),
        onPressed: onPressed,
        child: Text(text));
  }
}
