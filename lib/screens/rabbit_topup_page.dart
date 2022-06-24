import 'dart:developer';

import 'package:bts_plus/components/buttons/layout/secondary_button.dart';
import 'package:bts_plus/components/forms/layout/primary_dropdown.dart';
import 'package:bts_plus/components/forms/layout/primary_textformfield.dart';
import 'package:bts_plus/components/headers/secondary_header.dart';
import 'package:bts_plus/components/primary_scaffold.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/providers/auth_provider.dart';
import 'package:bts_plus/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/buttons/layout/primary_button.dart';
import '../components/forms/layout/primary_textfield.dart';
import '../components/primary_divider.dart';
import '../services/rabbit_controller.dart';

class RabbitTopUpPage extends ConsumerStatefulWidget {
  const RabbitTopUpPage({Key? key}) : super(key: key);

  @override
  RabbitTopUpPageState createState() => RabbitTopUpPageState();
}

class RabbitTopUpPageState extends ConsumerState<RabbitTopUpPage> {
  String paymentMethod = 'Cash';
  double amount = 0;
  TextEditingController atmCardController = TextEditingController();
  TextEditingController atmPinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(authProvider);
  }

  onAmountChanged(double value) {
    amount = value;
  }

  onPaymentChanged(String value) {
    setState(() {
      paymentMethod = value;
    });
  }

  onConfirm() async {
    final navigator = Navigator.of(context);
    final user = ref.watch(authProvider);
    final String rabbitUserName = user?.userName ?? '';
    await topUpRabbitCard(rabbitUserName, amount, context: context);
    if (!mounted) return;
    await ref.read(authProvider.notifier).refreshUserRabbitCard(context);
    navigator.push(MaterialPageRoute(
        builder: (context) => const MainPage(
              pageIndex: 1,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(kWidth(context) * 0.05),
          child: PrimaryButton(
              color: kRabbitThemeColor, text: 'Confirm', onPressed: onConfirm),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          const SecondaryHeader(
            color: kRabbitThemeColor,
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
    setState(() {
      amount = newAmount;
    });

    _amountController.text = amount.toStringAsFixed(0);

    onAmountChanged(newAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kWidth(context) * 0.0475),
      child: Column(
        children: [
          Container(
              child: const Text('Enter Amount (฿)', style: kHeader3TextStyle)),
          Container(
            margin: EdgeInsets.symmetric(vertical: kHeight(context) * 0.01),
            width: kWidth(context) * 0.4,
            child: PrimaryTextFormField(
              controller: _amountController,
              title: 'Enter amount',
              keyboardType: TextInputType.number,
              style: kBigHeaderTextStyle,
              decoration: kTopUpTextFieldDecorationWithHintText('Enter amount',
                  color: kRabbitThemeColor),
            ),
          ),
          Wrap(
            children: [
              for (double topUp in quickTopUp)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SecondaryButton(
                      color: kRabbitThemeColor,
                      text: '฿ ${topUp.toStringAsFixed(0)}',
                      onPressed: () => setAmount(topUp)),
                ),
            ],
          ),
          const PrimaryDivider(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: kWidth(context) * 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: kHeader3TextStyle),
                Text('฿ ${amount}', style: kHeader3TextStyle),
              ],
            ),
          ),
        ],
      ),
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
        margin: EdgeInsets.symmetric(
            vertical: kHeight(context) * 0.01,
            horizontal: kWidth(context) * 0.05),
        child: Column(children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: kHeight(context) * 0.025),
              width: double.infinity,
              child: Text('Payment Options', style: kHeader3TextStyle)),
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
                Container(
                  margin: EdgeInsets.only(top: kHeight(context) * 0.02),
                  child: PrimaryTextFormField(
                    focusBorderColor: kRabbitThemeColor,
                    title: 'Enter ATM Number',
                    controller: atmCardController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(16)
                    ],
                    keyboardType: TextInputType.number,
                  ),
                ),
                PrimaryTextFormField(
                  focusBorderColor: kRabbitThemeColor,
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
