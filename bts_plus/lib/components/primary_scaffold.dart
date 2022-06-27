import 'package:flutter/material.dart';

class PrimaryScaffold extends StatelessWidget {
  const PrimaryScaffold(
      {Key? key,
      required this.body,
      this.appbar,
      this.bottomNavigationBar,
      this.resizeToAvoidBottomInset = false,
      this.floatingActionButton,
      this.floatingActionButtonLocation})
      : super(key: key);
  final Widget body;
  final AppBar? appbar;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: SafeArea(child: body),
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
