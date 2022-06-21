import 'package:bts_plus/components/buttons/layout/alternate_link_button.dart';
import 'package:bts_plus/components/buttons/layout/primary_button.dart';
import 'package:bts_plus/components/primary_scaffold.dart';
import 'package:bts_plus/screens/bts_home_page.dart';
import 'package:bts_plus/screens/main_page.dart';
import 'package:flutter/material.dart';

class AuthenticationLayoutPage extends StatelessWidget {
  const AuthenticationLayoutPage(
      {Key? key,
      required this.title,
      required this.imageName,
      required this.formChild,
      required this.alternativeTitle,
      required this.alternativeLinkName,
      required this.alternativeLinkOnPressed})
      : super(key: key);
  final String title;
  final String imageName;
  final Widget formChild;
  final String alternativeTitle;
  final String alternativeLinkName;
  final Function() alternativeLinkOnPressed;
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      ImageWithText(image: imageName, text: title),
      formChild,
      PrimaryButton(
        text: title,
      ),
      AlternateLinkButton(
          title: alternativeTitle,
          linkName: alternativeLinkName,
          onPressed: alternativeLinkOnPressed),
      PrimaryButton(
          text: 'Home Page',
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          }),
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
      child: Column(
        children: <Widget>[
          Image.asset('assets/images/$image'),
          Text(text),
        ],
      ),
    );
  }
}
