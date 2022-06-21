import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlternateLinkButton extends StatelessWidget {
  const AlternateLinkButton(
      {Key? key,
      required this.title,
      required this.linkName,
      required this.onPressed})
      : super(key: key);
  final String title;
  final String linkName;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        TextButton(onPressed: onPressed, child: Text(linkName))
      ],
    );
  }
}
