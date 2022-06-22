import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/screens/main_page.dart';
import 'package:bts_plus/services/btsController.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime? birthDate;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
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
                          primary: kThemeColor, // header background color
                          onPrimary: kThemeFontColor, // header text color
                          onSurface: kPrimaryFontColor, // body text color
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            primary: kThemeColor, // button text color
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
                          birthDate = value,
                          _dateOfBirthController.text =
                              '${value.day}/${value.month}/${value.year}',
                        }
                    });
              },
              validator: basicValidator()),
          SizedBox(height: kHeight(context) * 0.02),
          PrimaryButton(
            text: 'Register',
            onPressed: () async {
              if (birthDate != null && _formKey.currentState!.validate()) {
                User newUser = User(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    userName: _usernameController.text,
                    password: _passwordController.text,
                    birthDate: birthDate!);
                User? user = await addUser(newUser, context: context);

                ref.read(authProvider.notifier).setCurrentUser(user);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
