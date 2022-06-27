import 'package:rabbit_shop/constants.dart';
import 'package:rabbit_shop/domains/user.dart';
import 'package:rabbit_shop/screens/login_page.dart';
import 'package:rabbit_shop/screens/main_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: kThemeFontColor),
      // initialRoute: '/login',
      // routes: {
      //   // When navigating to the "/" route, build the FirstScreen widget.
      //   '/': (context) => const MainPage(),
      //   // When navigating to the "/second" route, build the SecondScreen widget.
      //   '/login': (context) => const LoginPage(),
      //   '/register': (context) => const RegisterPage(),
      //   // 'purchase_ticket': (context) => const BTSTicketPurchasePage(),
      // },
      home: MainPage(),
      title: 'Rabbit Shop',
    );
  }
}
