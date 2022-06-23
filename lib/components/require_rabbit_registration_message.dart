import 'package:bts_plus/components/buttons/layout/primary_button.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/screens/rabbit_register_page.dart';
import 'package:flutter/material.dart';

class RequireRabbitRegistrationMessage extends StatelessWidget {
  const RequireRabbitRegistrationMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: kWidth(context) * 0.1, vertical: kHeight(context) * 0.1),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.all(kWidth(context) * 0.05),
              child: Image.asset('assets/images/rabbit_logo.png')),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Please register Rabbit card to continue',
                style: kHeader3TextStyle),
          ),
          PrimaryButton(
            color: kRabbitThemeColor,
            text: 'Register',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RabbitRegisterPage()));
            },
          )
        ],
      ),
    );
  }
}
