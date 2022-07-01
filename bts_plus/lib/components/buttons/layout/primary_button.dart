// OutlinedButton

import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/primary_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton(
      {Key? key,
      required this.text,
      this.onPressed,
      this.color = kBTSThemeColor})
      : super(key: key);
  final String text;
  final Function()? onPressed;
  final Color color;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool isProcessing = false;
  @override
  Widget build(BuildContext context) {
    return isProcessing
        ? const SecondaryButton(
            text: 'Processing...', color: kSecondaryFontColor)
        : OutlinedButton(
            style: OutlinedButton.styleFrom(
              // side: BorderSide(color: color, width: 2.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              primary: kThemeFontColor,
              backgroundColor: widget.color,
              textStyle: kBodyTextStyle,
            ),
            onPressed: () async {
              setState(() {
                isProcessing = true;
              });
              await widget.onPressed?.call();
              setState(() {
                isProcessing = false;
              });
            },
            child: Text(widget.text));
    ;
  }
}
