import 'package:bts_plus/components/forms/layout/primary_textfield.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text('Login Form'),
          PrimaryTextfield(title: 'ID'),
          PrimaryTextfield(title: 'Password'),
        ],
      ),
    );
  }
}
