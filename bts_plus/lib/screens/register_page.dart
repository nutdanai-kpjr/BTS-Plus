import 'package:bts_plus/components/forms/registration_form.dart';
import 'package:bts_plus/screens/layout/authentication_page.dart';
import 'package:bts_plus/screens/login_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthenticationLayoutPage(
        title: 'Register',
        imageName: 'bts_logo.png',
        isShowImage: false,
        formChild: RegistrationForm(),
        alternativeTitle: 'Already have account?',
        alternativeLinkName: 'Login',
        alternativeLinkOnPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        });
  }
}
