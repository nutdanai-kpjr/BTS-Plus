import 'package:rabbit_shop/components/buttons/layout/primary_button.dart';
import 'package:rabbit_shop/components/forms/layout/primary_textformfield.dart';
import 'package:rabbit_shop/components/utils.dart';
import 'package:rabbit_shop/providers/auth_provider.dart';
import 'package:rabbit_shop/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domains/user.dart';
import '../../services/rabbit_shop_controller.dart';

class LoginForm extends ConsumerWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'bts1234');
  final _passwordController = TextEditingController(text: 'bts1234');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          PrimaryButton(
            text: 'Login',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final navigator = Navigator.of(context);
                User? user = await loginUser(
                  _usernameController.text,
                  _passwordController.text,
                  context: context,
                );
                ref.read(authProvider.notifier).setCurrentUser(user);
                navigator.pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MainPage(),
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
