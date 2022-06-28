import 'package:bts_plus/screens/rabbit_home_page.dart';
import 'package:flutter/material.dart';

import '../../../screens/bts_home_page.dart';

class ButtomNavigatorButtons extends StatelessWidget {
  const ButtomNavigatorButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BTSHomeNavPage()));
            },
            icon: const Icon(Icons.home)),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RabbitHomeNavPage()));
            },
            icon: const Icon(Icons.credit_card)),
      ],
    );
  }
}
