import 'package:bts_plus/components/primary_scaffold.dart';
import 'package:bts_plus/constants.dart';
import 'package:bts_plus/providers/auth_provider.dart';
import 'package:bts_plus/screens/bts_home_page.dart';
import 'package:bts_plus/screens/rabbit_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../domains/user.dart';
import 'login_page.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key, this.pageIndex = 0}) : super(key: key);
  final int pageIndex;

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  late int _pageIndex = widget.pageIndex;
  final List _children = [
    const BTSHomeNavPage(),
    const RabbitHomeNavPage(),
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
          iconSize: 24,
          backgroundColor: kThemeFontColor,
          unselectedFontSize: kBody4FontSize,
          selectedLabelStyle: kBody3TextStyle,
          selectedItemColor: kHeaderFontColor,
          onTap: onTabTapped,
          currentIndex: _pageIndex, // this will be set when a new tab is tapped
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.train),
              label: 'My Ticket',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.idCard),
              label: 'My Rabbit Card',
            ),
          ],
        ),
        body: _children[_pageIndex]);
  }
}
