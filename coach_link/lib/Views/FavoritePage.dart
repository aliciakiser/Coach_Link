import 'package:flutter/material.dart';
import 'package:coach_link/Control/SearchMethod.dart';
import 'package:coach_link/Model/User.dart';
import 'package:coach_link/Control/CoachesDBHelperFunctions_sqlite.dart';
import 'package:coach_link/Model/UpdateUser.dart';

class FavoritePage extends StatefulWidget {
  String uid = "";
  FavoritePage({Key? key, required this.uid}) : super(key: key);
  @override
  _FavoritePageState createState() =>
      // ignore: no_logic_in_create_state
      _FavoritePageState(uid: uid);
}

class _FavoritePageState extends State<FavoritePage> {
  String uid = "";
  List<String> coachUids = [];
  List<CoachUser> coachList = [];

  _FavoritePageState({required this.uid});

  Future<void> _getCoachList() async {
    coachUids = await UpdateUser(uid: uid).getFriends();
    for (String uid in coachUids) {
      CoachUser? user = await CoachesDBHelperFunctions.instance.getUser(uid);
      coachList.add(user!);
    }
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    _getCoachList();
    super.initState();
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
            subtitle: Text("email: " +
                user.email +
                "\n" +
                "Specialization: " +
                user.specialization),
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
                  child: Text('DisConnect'.toUpperCase()),
                  onPressed: () {
                    UpdateUser(uid: uid).removeFriend(user.uid);
                  },
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
    Widget body;
    if (coachList.length == 0) {
      body = const Center(
        child: Text("No Coaches Found"),
      );
    } else {
      body = Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            for (CoachUser user in coachList) _singlePostBody(user),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("My Favorite Coaches"),
      ),
      body: body,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
