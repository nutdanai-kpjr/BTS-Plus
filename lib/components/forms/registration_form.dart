import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/primary_divider.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/screens/main_page.dart';
import 'package:bts_plus/services/btsController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domains/user.dart';
import '../../providers/auth_provider.dart';
import '../buttons/layout/primary_button.dart';
import '../utils.dart';
import 'layout/primary_textformfield.dart';

class RegistrationForm extends ConsumerWidget {
  RegistrationForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();

  final _rabbitPinController = TextEditingController();
  final _confirmRabbitPinController = TextEditingController();

  _buildBTSForm(context, {required setBirthDate}) {
    DateTime? birthDate;
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
            validator: basicValidator()),
        PrimaryTextFormField(
            title: 'Password',
            controller: _passwordController,
            obscureText: true,
            validator: basicValidator()),
        PrimaryTextFormField(
            title: 'Confirm Password',
            controller: _confirmPasswordController,
            obscureText: true,
            validator: basicValidator()),
        PrimaryTextFormField(
            title: 'First Name',
            controller: _firstNameController,
            validator: basicValidator()),
        PrimaryTextFormField(
            title: 'Last Name',
            controller: _lastNameController,
            validator: basicValidator()),
        PrimaryTextFormField(
            title: 'Date of Birth',
            controller: _dateOfBirthController,
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
              ).then((value) => {
                    if (value != null)
                      {
                        setBirthDate(value),
                        birthDate = value,
                        _dateOfBirthController.text = getFormatDate(birthDate!),
                      }
                  });
            },
            validator: basicValidator()),
        PrimaryDivider(
          indent: kWidth(context) * 0.02,
          endIndent: kWidth(context) * 0.02,
        ),
      ],
    );
  }

  _buildRabbitPinForm(context) {
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
            validator: basicValidator()),
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
            validator: basicValidator()),
        PrimaryDivider(
          indent: kWidth(context) * 0.02,
          endIndent: kWidth(context) * 0.02,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime? birthDate;
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

                ref.read(authProvider.notifier).setCurrentUser(user);
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
