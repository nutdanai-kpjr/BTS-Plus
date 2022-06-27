import 'dart:developer';

import 'package:rabbit_shop/components/buttons/layout/secondary_button.dart';
import 'package:rabbit_shop/components/forms/layout/primary_dropdown.dart';
import 'package:rabbit_shop/components/primary_divider.dart';
import 'package:rabbit_shop/constants.dart';
import 'package:rabbit_shop/screens/main_page.dart';
import 'package:rabbit_shop/services/rabbit_shop_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domains/user.dart';
import '../../providers/auth_provider.dart';
import '../buttons/layout/primary_button.dart';
import '../utils.dart';
import 'layout/primary_textformfield.dart';

class RegistrationForm extends ConsumerWidget {
  RegistrationForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'testshop');
  // final _passwordController = TextEditingController(text: '123456');
  // final _confirmPasswordController = TextEditingController(text: '123456');
  final _shopNameController = TextEditingController(text: 'Tester');

  final _rabbitPinController = TextEditingController(text: '123456');
  final _confirmRabbitPinController = TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? shopType;

    setShopType(String? selectedRabbitCardType) {
      shopType = selectedRabbitCardType;
    }

    _buildForm(context, {required setShopType}) {
      return Column(
        children: [
          PrimaryTextFormField(
              title: 'Username',
              controller: _usernameController,
              validator: userNameValidator()),
          // PrimaryTextFormField(
          //     title: 'Password',
          //     controller: _passwordController,
          //     obscureText: true,
          //     validator: passwordValidatior()),
          // PrimaryTextFormField(
          //     title: 'Confirm Password',
          //     controller: _confirmPasswordController,
          //     obscureText: true,
          //     validator: confirmPasswordValidatior(_confirmPasswordController)),
          PrimaryTextFormField(
              title: 'Shop Name',
              controller: _shopNameController,
              validator: shopnNameValidator()),
          PrimaryTextFormField(
              title: 'PIN (6 Numbers)',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(6)
              ],
              keyboardType: TextInputType.number,
              controller: _rabbitPinController,
              focusBorderColor: kThemeColor,
              obscureText: true,
              validator: pinValidatior()),
          PrimaryTextFormField(
              title: 'Confirm PIN',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(6)
              ],
              keyboardType: TextInputType.number,
              controller: _confirmRabbitPinController,
              focusBorderColor: kThemeColor,
              obscureText: true,
              validator: confirmPinValidatior(_rabbitPinController)),
          Container(
            margin: EdgeInsets.all(kWidth(context) * 0.02),
            child: PrimaryDropDown(
              title: 'Type',
              focusBorderColor: kThemeColor,
              items: const ['Lazada', 'Restaruant', 'BTS'],
              defaultValue: 'Lazada',
              onChanged: (value) {
                setShopType(value);
              },
            ),
          ),
        ],
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: kHeight(context) * 0.02),
          _buildForm(context, setShopType: setShopType),
          PrimaryButton(
            text: 'Register',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final navigator = Navigator.of(context);
                User newUser = User(
                    userName: _usernameController.text,
                    password: _rabbitPinController.text,
                    shopName: _shopNameController.text,
                    shopType: shopType?.toUpperCase() ?? 'LAZADA');
                User? user = await addUser(newUser, context: context);

                ref.read(authProvider.notifier).setCurrentUser(user);

                navigator.pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MainPage(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
