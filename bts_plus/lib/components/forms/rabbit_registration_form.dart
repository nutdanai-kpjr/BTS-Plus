import 'package:bts_plus/constants.dart';
import 'package:bts_plus/domains/rabbit_card.dart';
import 'package:bts_plus/providers/auth_provider.dart';
import 'package:bts_plus/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/rabbit_controller.dart';
import '../buttons/layout/primary_button.dart';
import '../utils.dart';
import 'layout/primary_textformfield.dart';

class RabbitRegistrationForm extends ConsumerWidget {
  RabbitRegistrationForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final _rabbitPinController = TextEditingController();
  final _confirmRabbitPinController = TextEditingController();
  // tofix
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final firstNameController =
        TextEditingController(text: user?.firstName ?? ''); //TOFIX
    final lastNameController =
        TextEditingController(text: user?.lastName ?? ''); //TOFIX
    final usernameController =
        TextEditingController(text: user?.userName ?? ''); //TOFIX
    final dateOfBirthController = TextEditingController(
        text: getFormatDate(user?.birthDate ?? DateTime.now()));
    final DateTime birthDate = user?.birthDate ?? DateTime.now();
    final String? btsUserId = user?.id;
    String type = 'Adult';

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: kHeight(context) * 0.025),
            child: const Text(
              'Register your rabbit card',
              style: kHeader2TextStyle,
            ),
          ),
          PrimaryTextFormField(
              title: 'PIN (6 Numbers)',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(6)
              ],
              keyboardType: TextInputType.number,
              controller: _rabbitPinController,
              focusBorderColor: kRabbitThemeColor,
              obscureText: true,
              validator: pinValidatior()),
          PrimaryTextFormField(
              title: 'Confirm PIN',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(6)
              ],
              keyboardType: TextInputType.number,
              controller: _confirmRabbitPinController,
              focusBorderColor: kRabbitThemeColor,
              obscureText: true,
              validator: confirmPinValidatior(_rabbitPinController)),
          PrimaryTextFormField(
              title: 'Username',
              controller: usernameController,
              focusBorderColor: kRabbitThemeColor,
              readOnly: true,
              validator: userNameValidator()),
          PrimaryTextFormField(
              title: 'First Name',
              controller: firstNameController,
              focusBorderColor: kRabbitThemeColor,
              maxLength: 50,
              readOnly: true,
              validator: nameValidator()),
          PrimaryTextFormField(
              title: 'Last Name',
              readOnly: true,
              controller: lastNameController,
              maxLength: 50,
              focusBorderColor: kRabbitThemeColor,
              validator: nameValidator()),
          PrimaryTextFormField(
            readOnly: true,
            title: 'Date of Birth',
            controller: dateOfBirthController,
            focusBorderColor: kRabbitThemeColor,
          ),
          // Container(
          //   margin: EdgeInsets.all(kWidth(context) * 0.05),
          //   child: PrimaryDropDown(
          //     title: 'Type',
          //     focusBorderColor: kRabbitThemeColor,
          //     items: const ['Student', 'Adult', 'Senior'],
          //     defaultValue: 'Adult',
          //     onChanged: (value) {
          //       type = value;
          //     },
          //   ),
          // ),
          PrimaryButton(
            color: kRabbitThemeColor,
            text: 'Register',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final navigator = Navigator.of(context);
                final RabbitCard newRabbitCard = RabbitCard(
                    balance: 0.0,
                    type: type,
                    pin: _rabbitPinController.text,
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    userName: usernameController.text,
                    btsUserId: btsUserId,
                    birthDate: birthDate);
                await addRabbitCard(newRabbitCard, context: context);
                navigator.push(MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ));
              }
            },
          )
        ],
      ),
    );
  }
}
