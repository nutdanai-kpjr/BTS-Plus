import 'package:flutter/material.dart';

import '../../../constants.dart';

class BackNavigatorButton extends StatelessWidget {
  const BackNavigatorButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
            onPressed: () {
              onPressed?.call();
              Navigator.maybePop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kThemeFontColor,
              size: kBodyFontSize,
            ),
            label: Text('Back',
                style: kBody2TextStyle.copyWith(color: kThemeFontColor))),
      ],
    );
  }
}
