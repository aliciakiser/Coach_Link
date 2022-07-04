import 'package:flutter/material.dart';
import 'package:coach_link/Control/SearchMethod.dart';
import 'package:coach_link/Model/User.dart';

class SearchLandingPage extends StatefulWidget {
  String keyword = "";
  SearchLandingPage({Key? key, required this.keyword}) : super(key: key);
  @override
  _SearchLandingPageState createState() =>
      _SearchLandingPageState(keyword: keyword);
}

class _SearchLandingPageState extends State<SearchLandingPage> {
  String keyword = "";
  List<CoachUser> coachList = [];

  _SearchLandingPageState({required this.keyword});

  Future<void> _getCoachList() async {
    coachList = await SearchMethod.searchCoach(keyword);
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCoachList();
  }

  Widget _singlePostBody(CoachUser user) {
    return Card(
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
              child: Image.asset(
                'assets/banner.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text(user.firstName),
            ),
            title: Text(user.firstName + " " + user.lastName),
            subtitle: Text("email: " + user.email),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              "Personal info",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ButtonTheme(
            child: ButtonBar(
              children: <Widget>[
                TextButton(
                  child: Text('Connect'.toUpperCase()),
                  onPressed: () {},
                ),
                TextButton(
                  child: Text('Message'.toUpperCase()),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Results for: " + keyword),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            for (CoachUser user in coachList) _singlePostBody(user),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
