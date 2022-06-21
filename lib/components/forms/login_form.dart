import 'package:bts_plus/components/buttons/layout/primary_button.dart';
import 'package:bts_plus/components/forms/layout/primary_textformfield.dart';
import 'package:bts_plus/components/utils.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text('Login Form'),
          PrimaryTextFormField(
              title: 'ID',
              controller: _usernameController,
              validator: basicValidator()),
          PrimaryTextFormField(
              title: 'Password',
              controller: _passwordController,
              obscureText: true,
              validator: basicValidator()),
          PrimaryButton(
            text: 'Login',
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
          )
        ],
      ),
    );
  }
}
