import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/buttons/topup_button.dart';
import 'package:bts_plus/components/cards/layout/primary_card.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/screens/main_page.dart';
import 'package:flutter/material.dart';

class NoRabbitCard extends StatelessWidget {
  const NoRabbitCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          'No Rabbit Card',
          style: kHeader2TextStyle,
        ),
        SecondaryButton(
            text: 'Register',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainPage(
                            pageIndex: 1,
                          )));
            }),
      ],
    ));
  }
}
