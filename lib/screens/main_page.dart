import 'package:bts_plus/components/primary_scaffold.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/providers/auth_provider.dart';
import 'package:bts_plus/screens/bts_home_page.dart';
import 'package:bts_plus/screens/rabbit_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domains/user.dart';
import 'login_page.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  int _pageIndex = 0;
  final List _children = [
    const BTSHomeNavPage(),
    const RabbitHomeNavPage(haveRabbitCard: true),
    const RabbitHomeNavPage(haveRabbitCard: false),
  ];
  void onTabTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    ref.read(authProvider);
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(authProvider);
    return user == null ? const LoginPage() : _buildMainPage(context);
  }

  Widget _buildMainPage(context) {
    return PrimaryScaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: kThemeColor,
          onTap: onTabTapped,
          currentIndex: _pageIndex, // this will be set when a new tab is tapped
          items: const [
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
  }
}
