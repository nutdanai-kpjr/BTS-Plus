import 'package:bts_plus/domains/user.dart';
import 'package:bts_plus/screens/login_page.dart';
import 'package:bts_plus/screens/main_page.dart';
import 'package:bts_plus/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import 'providers/auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // initialRoute: '/login',
      // routes: {
      //   // When navigating to the "/" route, build the FirstScreen widget.
      //   '/': (context) => const MainPage(),
      //   // When navigating to the "/second" route, build the SecondScreen widget.
      //   '/login': (context) => const LoginPage(),
      //   '/register': (context) => const RegisterPage(),
      //   // 'purchase_ticket': (context) => const BTSTicketPurchasePage(),
      // },
      home: LoginPage(),
      title: 'BTS Plus',
    );
  }
}
