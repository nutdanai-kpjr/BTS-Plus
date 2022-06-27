import 'package:bts_plus/components/buttons/layout/back_navigator_button.dart';
import 'package:bts_plus/components/forms/rabbit_registration_form.dart';
import 'package:bts_plus/components/forms/registration_form.dart';
import 'package:bts_plus/components/primary_scaffold.dart';
import 'package:bts_plus/screens/layout/authentication_page.dart';
import 'package:bts_plus/screens/login_page.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RabbitRegisterPage extends StatelessWidget {
  const RabbitRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PrimaryScaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(child: RabbitRegisterSection()));
  }
}

class RabbitRegisterSection extends StatelessWidget {
  const RabbitRegisterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BackNavigatorButton(
          color: kHeaderFontColor,
        ),
        Container(
            margin: EdgeInsets.all(kWidth(context) * 0.025),
            child: RabbitRegistrationForm()),
      ],
    );
  }
}
