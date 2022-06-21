import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/forms/layout/primary_textfield.dart';
import 'package:bts_plus/screens/main_page.dart';
import 'package:flutter/material.dart';

import '../../domains/user.dart';
import '../buttons/layout/primary_button.dart';
import '../utils.dart';
import 'layout/primary_textformfield.dart';

class RegisterationForm extends StatelessWidget {
  RegisterationForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime? birthDate;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text('Register Form'),
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
          SecondaryButton(
              text: 'Date of Birth',
              onPressed: () async {
                birthDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2050),
                );
              }),
          PrimaryButton(
            text: 'Register',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                User newUser = User(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    userName: _usernameController.text,
                    password: _passwordController.text,
                    birthDate: birthDate ?? DateTime.now());
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
