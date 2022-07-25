import 'package:coach_link/Views/newPost.dart';
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
    _bottomNavPages
      ..add(MyHomePage(title: "Home", uid: this.uid))
      ..add(const SearchPage())
      ..add(ProfilePage(uid: this.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _bottomNavPages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                setState(() {
                  //_currentIndex = 0;
                });
              },
            ),
            const SizedBox(),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
        shape: const CircularNotchedRectangle(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => newPost(uid: uid),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
