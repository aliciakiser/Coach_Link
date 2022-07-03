import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'ProfilePage.dart';
import "SearchPage.dart";
import "HomePage.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StartPage extends StatefulWidget {
  String uid = "";
  StartPage({Key? key, required this.uid}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _StartPageState createState() => _StartPageState(uid: uid);
}

class _StartPageState extends State<StartPage> {
  int _currentIndex = 0;
  List<Widget> _bottomNavPages = [];
  String uid = "";

  _StartPageState({required this.uid});
  @override
  void initState() {
    super.initState();
    _bottomNavPages
      ..add(MyHomePage(title: "Home", uid: this.uid))
      ..add(const SearchPage())
      ..add(ProfilePage(uid: this.uid));
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
