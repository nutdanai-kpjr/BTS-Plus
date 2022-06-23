import 'package:bts_plus/components/buttons/layout/primary_button.dart';
import 'package:bts_plus/components/forms/layout/primary_textformfield.dart';
import 'package:bts_plus/components/utils.dart';
import 'package:bts_plus/providers/auth_provider.dart';
import 'package:bts_plus/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domains/user.dart';
import '../../services/btsController.dart';

class LoginForm extends ConsumerWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
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
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                User? user = await loginUser(
                  _usernameController.text,
                  _passwordController.text,
                  context: context,
                  kIsMockUp: true,
                );
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
