import 'package:flutter/material.dart';

const Color kBTSThemeColor = Color(0xFF0060A6);
const Color kThemeFontColor = Color(0xFFFFFFFF);
const Color kThemeSecondaryBackgroundColor = Color(0xFFFCFDFE);
const Color kHeaderFontColor = Color(0XFF393939);
const Color kPrimaryFontColor = Color(0XFF737373);
const Color kSecondaryFontColor = Color(0XFFA8A8A8);
const Color kBorderColor = Color(0XFFECECEC);
const Color kGreen = Color(0XFF009245);
const double kBigHeaderFontSize = 36.0;
const double kHeader1FontSize = 24.0;
const double kHeader2FontSize = 20.0;
const double kHeader3FontSize = 16.0;
const double kHeader4FontSize = 14.0;
const double kHeader5FontSize = 12.0;

const double kBodyFontSize = 16.0;
const double kBody2FontSize = 14.0;
const double kBody3FontSize = 12.0;

const TextStyle kBigHeaderTextStyle = TextStyle(
  fontSize: kBigHeaderFontSize,
  fontWeight: FontWeight.bold,
  color: kHeaderFontColor,
);

const TextStyle kHeader1TextStyle = TextStyle(
  fontSize: kHeader1FontSize,
  fontWeight: FontWeight.bold,
  color: kHeaderFontColor,
);
const TextStyle kHeader2TextStyle = TextStyle(
  fontSize: kHeader2FontSize,
  fontWeight: FontWeight.bold,
  color: kHeaderFontColor,
);

const TextStyle kHeader3TextStyle = TextStyle(
  fontSize: kHeader3FontSize,
  fontWeight: FontWeight.bold,
  color: kHeaderFontColor,
);

const TextStyle kHeader4TextStyle = TextStyle(
  fontSize: kHeader4FontSize,
  fontWeight: FontWeight.bold,
  color: kHeaderFontColor,
);

const TextStyle kHeader5TextStyle = TextStyle(
  fontSize: kHeader5FontSize,
  fontWeight: FontWeight.bold,
  color: kHeaderFontColor,
);
const TextStyle kBodyTextStyle = TextStyle(
  fontSize: kBodyFontSize,
  fontWeight: FontWeight.w500,
  color: kPrimaryFontColor,
);
const TextStyle kBody2TextStyle = TextStyle(
  fontSize: kBody2FontSize,
  color: kSecondaryFontColor,
);
const TextStyle kBody3TextStyle = TextStyle(
  fontSize: kBody3FontSize,
  color: kSecondaryFontColor,
);
InputDecoration kTextFieldDecorationWithHintText(String hintText) =>
    InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: kBTSThemeColor.withOpacity(0.5), width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(color: kBorderColor, width: 1.0),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          // fontSize: kListItemSubTitleFontSize,
          color: kSecondaryFontColor,
        ));

double kWidth(context) => MediaQuery.of(context).size.width;
double kHeight(context) => MediaQuery.of(context).size.height;
