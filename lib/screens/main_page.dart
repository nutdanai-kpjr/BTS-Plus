import 'package:bts_plus/components/primary_scaffold.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/screens/bts_home_page.dart';
import 'package:bts_plus/screens/rabbit_home_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _pageIndex = 0;
  final List _children = [
    BTSHomeNavPage(),
    RabbitHomeNavPage(haveRabbitCard: true),
    RabbitHomeNavPage(haveRabbitCard: false),
  ];
  void onTabTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: kThemeColor,
          onTap: onTabTapped,
          currentIndex: _pageIndex, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: 'Rabbit',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: 'Rabbit',
            ),
          ],
        ),
        body: _children[_pageIndex]);
    ;
  }
}
