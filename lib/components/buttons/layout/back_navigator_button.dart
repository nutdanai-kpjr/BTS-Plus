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
        BackButton(
          color: kThemeFontColor,
          onPressed: onPressed,
        ),
        InkWell(
          onTap: () {
            onPressed?.call();
            Navigator.maybePop(context);
          },
          child: Text(
            'Back',
            style: kBody2TextStyle.copyWith(color: kThemeFontColor),
          ),
        )
      ],
    );
  }
}
