import 'package:rabbit_shop/components/buttons/layout/alternate_link_button.dart';
import 'package:rabbit_shop/components/primary_scaffold.dart';
import 'package:rabbit_shop/constants.dart';
import 'package:flutter/material.dart';

class AuthenticationLayoutPage extends StatelessWidget {
  const AuthenticationLayoutPage(
      {Key? key,
      required this.title,
      required this.imageName,
      this.isShowImage = true,
      required this.formChild,
      required this.alternativeTitle,
      required this.alternativeLinkName,
      required this.alternativeLinkOnPressed})
      : super(key: key);
  final String title;
  final String imageName;
  final bool isShowImage;
  final Widget formChild;
  final String alternativeTitle;
  final String alternativeLinkName;
  final Function() alternativeLinkOnPressed;
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          isShowImage
              ? ImageWithText(image: imageName, text: title)
              : Container(
                  margin: EdgeInsets.only(top: kHeight(context) * 0.025),
                  child: Text(
                    title,
                    style: kBigHeaderTextStyle,
                  ),
                ),
          Container(
              margin: EdgeInsets.all(kWidth(context) * 0.05), child: formChild),
          Center(
            child: AlternateLinkButton(
                title: alternativeTitle,
                linkName: alternativeLinkName,
                onPressed: alternativeLinkOnPressed),
          ),
        ])));
  }
}

class ImageWithText extends StatelessWidget {
  const ImageWithText({Key? key, required this.image, required this.text})
      : super(key: key);
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kWidth(context) * 0.05),
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/$image',
            width: kWidth(context) * 0.3,
            height: kHeight(context) * 0.3,
          ),
          Text(
            text,
            style: kBigHeaderTextStyle,
          ),
        ],
      ),
    );
  }
}
