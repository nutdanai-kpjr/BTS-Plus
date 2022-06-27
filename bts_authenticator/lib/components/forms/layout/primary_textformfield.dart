import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';

class PrimaryTextFormField extends StatelessWidget {
  const PrimaryTextFormField(
      {Key? key,
      required this.title,
      this.decoration,
      this.controller,
      this.padding = const EdgeInsets.all(8.0),
      this.onChanged,
      this.keyboardType,
      this.obscureText = false,
      this.readOnly = false,
      this.inputFormatters,
      this.onTap,
      this.validator,
      this.style,
      this.focusBorderColor = kThemeColor})
      : super(key: key);
  final String title;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final EdgeInsetsGeometry padding;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool readOnly;
  final Function()? onTap;
  final InputDecoration? decoration;
  final Color focusBorderColor;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: TextFormField(
          onTap: onTap,
          readOnly: readOnly,
          validator: validator,
          obscureText: obscureText,
          onChanged: onChanged,
          controller: controller,
          style: style ?? kBodyTextStyle,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: decoration ??
              kTextFieldDecorationWithLabelText(title, color: focusBorderColor),
        ));
  }
}
