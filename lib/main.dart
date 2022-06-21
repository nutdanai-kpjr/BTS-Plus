import 'package:bts_plus/components/primary_scaffold.dart';
import 'package:bts_plus/screens/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BTS Plus',
      home: LoginPage(),
    );
  }
}
