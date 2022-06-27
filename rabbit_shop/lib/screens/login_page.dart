import 'package:rabbit_shop/components/forms/login_form.dart';
import 'package:rabbit_shop/components/forms/registration_form.dart';
import 'package:rabbit_shop/screens/layout/authentication_page.dart';
import 'package:rabbit_shop/screens/register_page.dart';
import 'package:flutter/material.dart';

import 'main_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthenticationLayoutPage(
        title: 'Login',
        imageName: 'rabbit_logo.png',
        formChild: LoginForm(),
        alternativeTitle: 'Don\'t have account yet?',
        alternativeLinkName: 'Register',
        alternativeLinkOnPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegisterPage()));
        });
  }
}
