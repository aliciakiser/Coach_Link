import 'package:flutter/material.dart';
import "login_page.dart";
import "SearchPage.dart";
import "HomePage.dart";

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int _currentIndex = 0;

  List<Widget> _bottomNavPages = []; // 底部导航栏各个可切换页面组

  @override
  void initState() {
    super.initState();
    _bottomNavPages
      ..add(const MyHomePage(title: "Home"))
      ..add(const SearchPage())
      ..add(const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _bottomNavPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
