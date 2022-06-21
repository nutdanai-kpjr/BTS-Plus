import 'package:bts_plus/components/forms/login_form.dart';
import 'package:bts_plus/screens/layout/authentication_page.dart';
import 'package:bts_plus/screens/register_page.dart';
import 'package:flutter/material.dart';

import 'main_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthenticationLayoutPage(
        title: 'Login',
        imageName: 'bts_logo.png',
        formChild: const LoginForm(),
        alternativeTitle: 'Don\'t have account yet?',
        alternativeLinkName: 'Register',
        alternativeLinkOnPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RegisterPage()));
        });
  }
}
