import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/buttons/topup_button.dart';
import 'package:bts_plus/components/cards/layout/primary_card.dart';
import 'package:flutter/material.dart';

class NoRabbitCard extends StatelessWidget {
  const NoRabbitCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
        child: Row(
      children: [
        Text('No Rabbit Card'),
      ],
    ));
  }
}
