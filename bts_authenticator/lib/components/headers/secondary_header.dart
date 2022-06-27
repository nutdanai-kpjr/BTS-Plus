import 'package:bts_authenticator/components/diaglogs/configuration_dialog.dart';
import 'package:bts_authenticator/screens/scanner_page.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../buttons/layout/back_navigator_button.dart';

class SecondaryHeader extends StatelessWidget {
  const SecondaryHeader({
    Key? key,
    required this.title,
    this.color = kThemeColor,
    this.onPopDialog,
  }) : super(key: key);
  final String title;
  final Color color;
  final Function()? onPopDialog;
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
          Text(
            title,
            style: kHeader2TextStyle.copyWith(
                color: kThemeFontColor, fontWeight: FontWeight.normal),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(
                Icons.settings,
                color: kThemeFontColor,
              ),
              onPressed: () async {
                await showConfigurationDialog(
                  context,
                );

                onPopDialog?.call();

                // showUserQRCodeDialog(context,
                //     user: ref.watch(authProvider)!);
              },
            ),
          )
        ],
      ),
    );
  }
}
