import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/cards/balance_card.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_provider.dart';

class PrimaryHeader extends ConsumerWidget {
  const PrimaryHeader(
      {Key? key, required this.title, required this.height, required this.card})
      : super(key: key);
  final String title;
  final double height;
  final Widget card;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: kThemeColor,
      height: height,
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: SecondaryButton(
                      text: 'Logout',
                      onPressed: () {
                        ref.read(authProvider.notifier).clearUser();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(color: kThemeFontColor),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: kWidth(context) * 0.02,
                      horizontal: kWidth(context) * 0.04),
                  child: card)),
        ],
      ),
    );
  }
}
