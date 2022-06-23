import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/cards/balance_card.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_provider.dart';

class PrimaryHeader extends ConsumerWidget {
  const PrimaryHeader(
      {Key? key,
      required this.title,
      required this.height,
      required this.card,
      this.color = kBTSThemeColor})
      : super(key: key);
  final String title;
  final double height;
  final Widget card;
  final Color color;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: color,
      height: height,
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: [
              Text(
                title,
                style: kHeader2TextStyle.copyWith(
                    color: kThemeFontColor, fontWeight: FontWeight.normal),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: kThemeFontColor,
                  ),
                  onPressed: () {
                    ref.read(authProvider.notifier).clearUser();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  },
                ),
              )
            ],
          ),
          Expanded(
              flex: 3,
              child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: kWidth(context) * 0.02,
                      horizontal: kWidth(context) * 0.04),
                  child: card)),
          SizedBox(height: kHeight(context) * 0.02)
        ],
      ),
    );
  }
}
