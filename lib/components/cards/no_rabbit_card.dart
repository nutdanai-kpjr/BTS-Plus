import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/buttons/topup_button.dart';
import 'package:bts_plus/components/cards/layout/primary_card.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/screens/main_page.dart';
import 'package:flutter/material.dart';

class NoRabbitCard extends StatelessWidget {
  const NoRabbitCard({Key? key, this.color = kBTSThemeColor}) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'No Rabbit Card',
          style: kHeader2TextStyle.copyWith(
              color: kSecondaryFontColor, fontSize: kBodyFontSize),
        ),
        // SizedBox(
        //   height: kHeight(context) * 0.05,
        //   width: kWidth(context) * 0.4,
        //   child: SecondaryButton(
        //       color: color,
        //       text: 'Register',
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => const MainPage(
        //                       pageIndex: 1,
        //                     )));
        //       }),
        // ),
      ],
    ));
  }
}
