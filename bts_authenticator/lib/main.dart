import 'package:bts_authenticator/screens/scanner_page.dart';
import 'package:bts_authenticator/services/authenticator_configuration.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthenticatorConfiguration.loadConfiguration();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BTS Scanner',
      home: ScannerPage(),
    );
  }
}
