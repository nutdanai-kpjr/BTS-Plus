import 'dart:developer';

import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/forms/layout/primary_dropdown.dart';
import 'package:bts_plus/components/headers/secondary_header.dart';
import 'package:bts_plus/components/primary_scaffold.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/buttons/layout/primary_button.dart';
import '../components/forms/layout/primary_textfield.dart';

class RabbitTopUpPage extends StatefulWidget {
  const RabbitTopUpPage({Key? key}) : super(key: key);

  @override
  State<RabbitTopUpPage> createState() => _RabbitTopUpPageState();
}

class _RabbitTopUpPageState extends State<RabbitTopUpPage> {
  String paymentMethod = 'Cash';
  double amount = 0;
  TextEditingController atmCardController = TextEditingController();
  TextEditingController atmPinController = TextEditingController();
  onAmountChanged(double value) {
    amount = value;
  }

  onPaymentChanged(String value) {
    paymentMethod = value;
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        bottomNavigationBar: PrimaryButton(
          text: 'Confirm',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainPage(
                          pageIndex: 1,
                        )));
          },
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          const SecondaryHeader(
            title: 'Top Up',
          ),
          TopUpAmountSection(
            onAmountChanged: onAmountChanged,
          ),
          RabbitPaymentSection(
            onPaymentChanged: onPaymentChanged,
            paymentMethod: paymentMethod,
            atmCardController: atmCardController,
            atmPinController: atmPinController,
          ),
          PrimaryButton(
            text: 'Confirm',
            onPressed: () {
              log('test');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainPage(
                            pageIndex: 1,
                          )));
            },
          )
        ])));
  }
}

class TopUpAmountSection extends StatefulWidget {
  const TopUpAmountSection({Key? key, required this.onAmountChanged})
      : super(key: key);
  final Function onAmountChanged;

  @override
  State<TopUpAmountSection> createState() => _TopUpAmountSectionState();
}

class _TopUpAmountSectionState extends State<TopUpAmountSection> {
  final TextEditingController _amountController =
      TextEditingController(text: '100');
  late Function onAmountChanged = widget.onAmountChanged;
  List<double> quickTopUp = [100, 200, 500, 1000];
  double amount = 100;
  setAmount(newAmount) {
    amount = newAmount;
    _amountController.text = amount.toStringAsFixed(0);

    onAmountChanged(newAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryTextfield(
          controller: _amountController,
          title: 'Enter amount',
          keyboardType: TextInputType.number,
        ),
        Wrap(
          children: [
            for (double topUp in quickTopUp)
              SecondaryButton(
                  text: '${topUp.toStringAsFixed(0)}',
                  onPressed: () => setAmount(topUp)),
          ],
        )
      ],
    );
  }
}

class RabbitPaymentSection extends StatelessWidget {
  RabbitPaymentSection(
      {Key? key,
      required this.paymentMethod,
      required this.onPaymentChanged,
      required this.atmCardController,
      required this.atmPinController})
      : super(key: key);
  final List<String> paymentMethods = ['Cash', 'ATM'];
  final String paymentMethod;
  final Function(String) onPaymentChanged;
  final TextEditingController atmCardController;
  final TextEditingController atmPinController;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      const Text('Payment Section'),
      PrimaryDropDown(
        title: 'Payment Method',
        focusBorderColor: kRabbitThemeColor,
        items: paymentMethods,
        defaultValue: paymentMethod,
        onChanged: onPaymentChanged,
      ),
      if (paymentMethod == 'ATM')
        Column(
          children: [
            PrimaryTextfield(
              title: 'Enter ATM Number',
              controller: atmCardController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(16)
              ],
              keyboardType: TextInputType.number,
            ),
            PrimaryTextfield(
              title: 'Enter ATM Pin',
              controller: atmPinController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(6)
              ],
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
          ],
        )
    ]));
  }
}
