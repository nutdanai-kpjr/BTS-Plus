import 'package:bts_plus/screens/bts_ticket_purchase_page.dart';
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BTSHomeNavPage()));
            },
            icon: Icon(Icons.home)),
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RabbitHomeNavPage()));
            },
            icon: Icon(Icons.credit_card)),
      ],
    );
  }
}
