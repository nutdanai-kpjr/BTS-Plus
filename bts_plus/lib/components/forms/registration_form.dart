import 'dart:developer';

import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/forms/layout/primary_dropdown.dart';
import 'package:bts_plus/components/primary_divider.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/screens/main_page.dart';
import 'package:bts_plus/services/bts_controller.dart';
import 'package:bts_plus/services/rabbit_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domains/rabbit_card.dart';
import '../../domains/user.dart';
import '../../providers/auth_provider.dart';
import '../buttons/layout/primary_button.dart';
import '../utils.dart';
import 'layout/primary_textformfield.dart';

class RegistrationForm extends ConsumerWidget {
  RegistrationForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'test');
  final _passwordController = TextEditingController(text: '123456');
  final _confirmPasswordController = TextEditingController(text: '123456');
  final _firstNameController = TextEditingController(text: 'John');
  final _lastNameController = TextEditingController(text: 'Doe');
  final _dateOfBirthController = TextEditingController(text: '1/1/1990');

  final _rabbitPinController = TextEditingController(text: '123456');
  final _confirmRabbitPinController = TextEditingController(text: '123456');
  final _isoBirthdate =
      TextEditingController(text: DateTime.utc(1990, 1, 1).toIso8601String());

  _buildBTSForm(context, {required setBirthDate}) {
    DateTime? birthDate = DateTime.utc(1990, 1, 1);

    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(kHeight(context) * .01),
            width: double.infinity,
            child: const Text(
              'BTS Section',
              textAlign: TextAlign.start,
              style: kHeader3TextStyle,
            )), //REFRACT
        PrimaryTextFormField(
            title: 'Username',
            controller: _usernameController,
            validator: userNameValidator()),
        PrimaryTextFormField(
            title: 'Password',
            controller: _passwordController,
            obscureText: true,
            validator: passwordValidatior()),
        PrimaryTextFormField(
            title: 'Confirm Password',
            controller: _confirmPasswordController,
            obscureText: true,
            validator: confirmPasswordValidatior(_passwordController)),
        PrimaryTextFormField(
            title: 'First Name',
            maxLength: 50,
            controller: _firstNameController,
            validator: nameValidator()),
        PrimaryTextFormField(
            title: 'Last Name',
            maxLength: 50,
            controller: _lastNameController,
            validator: nameValidator()),
        PrimaryTextFormField(
          title: 'Date of Birth',
          controller: _dateOfBirthController,
          validator: birthDateValidator(_isoBirthdate),
          readOnly: true,
          onTap: () {
            showDatePicker(
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: kBTSThemeColor, // header background color
                            onPrimary: kThemeFontColor, // header text color
                            onSurface: kPrimaryFontColor, // body text color
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              primary: kBTSThemeColor, // button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2050),
                    initialDatePickerMode: DatePickerMode.year)
                .then((value) {
              if (value != null) {
                birthDate = value;
                setBirthDate(value);
                _dateOfBirthController.text = getFormatDate(birthDate!);
                _isoBirthdate.text = birthDate!.toIso8601String();
                log('birthDate: ${_isoBirthdate.text}');
              }
            });
          },
        ),
        PrimaryDivider(
          indent: kWidth(context) * 0.02,
          endIndent: kWidth(context) * 0.02,
        ),
      ],
    );
  }

  _buildRabbitPinForm(
    context,
  ) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(kHeight(context) * .01),
            width: double.infinity,
            child: const Text(
              'Rabbit Card Section',
              textAlign: TextAlign.start,
              style: kHeader3TextStyle,
            )),
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
        PrimaryDivider(
          indent: kWidth(context) * 0.02,
          endIndent: kWidth(context) * 0.02,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime? birthDate = DateTime.utc(1990, 1, 1);

    setBirthDate(DateTime? selectedbirthdate) {
      birthDate = selectedbirthdate;
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: kHeight(context) * 0.02),
          _buildBTSForm(context, setBirthDate: setBirthDate),
          _buildRabbitPinForm(context),
          PrimaryButton(
            text: 'Register',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final navigator = Navigator.of(context);
                User newUser = User(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    userName: _usernameController.text,
                    password: _passwordController.text,
                    birthDate: birthDate!);
                User? user = await addUser(newUser, context: context);
                if (user != null) {
                  final RabbitCard newRabbitCard = RabbitCard(
                      balance: 0.0,
                      pin: _rabbitPinController.text,
                      firstName: user.firstName,
                      lastName: user.lastName,
                      userName: user.userName,
                      btsUserId: user.id,
                      birthDate: user.birthDate);
                  await addRabbitCard(newRabbitCard, context: context);
                  User? userAfterAddRabbit = await loginUser(
                      user.userName, user.password,
                      context: context);
                  ref
                      .read(authProvider.notifier)
                      .setCurrentUser(userAfterAddRabbit);
                } else {
                  ref.read(authProvider.notifier).setCurrentUser(user);
                }

                navigator.pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MainPage(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
