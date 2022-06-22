import 'package:bts_plus/components/forms/layout/primary_dropdown.dart';
import 'package:bts_plus/domains/rabbit_card.dart';
import 'package:bts_plus/providers/auth_provider.dart';
import 'package:bts_plus/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/rabbitController.dart';
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
        TextEditingController(text: user!.firstName); //TOFIX
    final lastNameController =
        TextEditingController(text: user.lastName); //TOFIX
    final usernameController =
        TextEditingController(text: user.userName); //TOFIX
    final DateTime birthDate = user.birthDate; //TOFIX
    String type = 'Adult';

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const Text('Register Form'),
          PrimaryTextFormField(
              title: 'Enter 6 PIN',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(6)
              ],
              keyboardType: TextInputType.number,
              controller: _rabbitPinController,
              obscureText: true,
              validator: basicValidator()),
          PrimaryTextFormField(
              title: 'Confirm 6 PIN',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(6)
              ],
              keyboardType: TextInputType.number,
              controller: _confirmRabbitPinController,
              obscureText: true,
              validator: basicValidator()),
          PrimaryTextFormField(
              title: 'Username',
              controller: usernameController,
              readOnly: true,
              validator: basicValidator()),
          PrimaryTextFormField(
              title: 'First Name',
              controller: firstNameController,
              readOnly: true,
              validator: basicValidator()),
          PrimaryTextFormField(
              title: 'Last Name',
              readOnly: true,
              controller: lastNameController,
              validator: basicValidator()),
          Text('Date of Birth ${birthDate.toIso8601String()}'),
          PrimaryDropDown(
            items: const ['Student', 'Adult', 'Senior'],
            defaultValue: 'Adult',
            onChanged: (value) {
              type = value;
            },
          ),
          PrimaryButton(
            text: 'Register',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final RabbitCard newRabbitCard = RabbitCard(
                    balance: 0.0,
                    type: type,
                    pin: _rabbitPinController.text,
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    userName: usernameController.text,
                    birthDate: birthDate);
                await addRabbitCard(newRabbitCard, context: context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
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
