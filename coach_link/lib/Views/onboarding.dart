import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_link/Views/StartPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coach_link/Model/UpdateUser.dart';
import 'package:coach_link/Model/User.dart';

class OnboardingPage extends StatefulWidget {
  String uid = "";
  OnboardingPage({Key? key, required this.uid}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState(uid: uid);
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  String uid = "";
  String sport = "";
  String specialization = "";
  TextEditingController _WorkExp = TextEditingController();
  TextEditingController _AwrdNAchv = TextEditingController();
  TextEditingController _degree_HighSchool = TextEditingController();
  TextEditingController _degree_College = TextEditingController();
  TextEditingController _location = TextEditingController();

  CoachUser? _coachUser;
  UpdateUser? _userProfile;

  _OnboardingPageState({required this.uid});

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 8,
      vsync: this,
    );
    _GetUserState();
  }

  Future<void> _GetUserState() async {
    _userProfile = UpdateUser(uid: uid);
    _coachUser = await _userProfile!.getCoach();
    sport = _coachUser!.sport;
    specialization = _coachUser!.specialization;
    _WorkExp.text = _coachUser!.WorkExp;
    _AwrdNAchv.text = _coachUser!.AwrdNAchv;
    _degree_HighSchool.text = _coachUser!.degree_HighSchool;
    _degree_College.text = _coachUser!.degree_College;
    _location.text = _coachUser!.location;
    if (mounted) setState(() {});
  }

  ActionCodeSettings acs = ActionCodeSettings(
    handleCodeInApp: true,
    url: "package:coach_link/Web/index.html",
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference docUser =
      FirebaseFirestore.instance.collection('users');

  List<String> specializations_List = [
    'Head coach',
    'Offensive coordinator',
    'Quaterback coach',
    'Offensive line coach',
    'Running backs coach',
    'Wide receivers coach',
    'Tight ends coach',
    'Defensive coordinator',
    'Defensive line coach',
    'Linebacker coach',
    'Secondary coach',
    'Special teams coach',
    'Graduate assistant',
    'Strength coach',
    'Recruiting coordinator',
    'Video coordinator',
    'Director of football operation',
    'Equipment manager'
  ];
  String? selectedSpecialization = "Head coach";

  List<String> sports_List = ['Football'];
  String? selectedSport = "Football";

  void UpdateUserInfo() {
    FirebaseFirestore.instance.collection('users').doc(uid).update({
      'WorkExp': _WorkExp.text,
      'AwrdNAchv': _AwrdNAchv.text,
      'degree_HighSchool': _degree_HighSchool.text,
      'degree_College': _degree_College.text,
      'location': _location.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                _createInitialPage(),
                _sports_page(),
                _specializations_page(),
                _WorkExp_page(),
                _AwrdNAchv_page(),
                _degree_page(),
                _location_page(),
                _createFinishedPage(),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black26)]),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TabPageSelector(
                  controller: tabController,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _createInitialPage() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: const Center(
        child: Text(
            "Please answer a few questions about yourself so that we can improve your chances of being seen in the search.\n\nSwipe to the right to begin. ->",
            style: TextStyle(fontSize: 20, color: Colors.black)),
      ),
    );
  }

  Container _createFinishedPage() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
              "You have finished the onboarding process!\nPlease click the button below to continue to the app.",
              style: TextStyle(fontSize: 20, color: Colors.black)),
          const SizedBox(height: 35),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              primary: Colors.white,
              backgroundColor: Colors.blue,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StartPage(
                          uid: uid,
                        )),
              );
              UpdateUserInfo();
            },
            child: const Text('Go to App'),
          ),
        ],
      ),
    );
  }

  Container _sports_page() {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "What sport are you interested in coaching?",
            style: const TextStyle(fontSize: 20, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          SizedBox(
              width: 240,
              child: DropdownButton<String>(
                value: selectedSport,
                items: sports_List
                    .map((spt) => DropdownMenuItem<String>(
                          value: spt,
                          child: Text(spt),
                        ))
                    .toList(),
                onChanged: (spt) {
                  setState(() {
                    selectedSport = spt;
                  });

                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .update({'sport': selectedSport});
                },
              ))
        ]));
  }

  Container _specializations_page() {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "What is your coaching specialty?",
            style: const TextStyle(fontSize: 20, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          SizedBox(
              width: 243,
              child: DropdownButton<String>(
                value: selectedSpecialization,
                items: specializations_List
                    .map((splzn) => DropdownMenuItem<String>(
                          value: splzn,
                          child: Text(splzn),
                        ))
                    .toList(),
                onChanged: (splzn) {
                  setState(() {
                    selectedSpecialization = splzn;
                  });

                  print(selectedSpecialization);
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .update({'specialization': selectedSpecialization});
                },
              ))
        ]));
  }

  Container _WorkExp_page() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("What coaching experience do you have?",
              style: const TextStyle(fontSize: 20, color: Colors.black)),
          const SizedBox(height: 30),
          TextField(
            controller: _WorkExp,
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ],
      ),
    );
  }

  Container _AwrdNAchv_page() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "Do you have any awards and achievements you would like to list?",
              style: const TextStyle(fontSize: 20, color: Colors.black)),
          const SizedBox(height: 30),
          TextField(
            controller: _AwrdNAchv,
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ],
      ),
    );
  }

  Container _degree_page() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "What degree did you get? Please enter the name of instituition and duration if applicable.  ",
              style: const TextStyle(fontSize: 20, color: Colors.black)),
          const SizedBox(height: 30),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "High School:",
                style: TextStyle(fontSize: 18, color: Colors.black),
              )),
          //const SizedBox(height: 30),
          TextField(
            controller: _degree_HighSchool,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                hintText: "ex:The Ohio State University(2018-2022)"),
            maxLines: null,
          ),
          const SizedBox(height: 30),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "College:",
                style: TextStyle(fontSize: 18, color: Colors.black),
              )),
          TextField(
            controller: _degree_College,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                hintText: "ex:The Ohio State University(2018-2022)"),
            maxLines: null,
          ),
        ],
      ),
    );
  }

  Container _location_page() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("What is your current location?",
              style: const TextStyle(fontSize: 20, color: Colors.black)),
          const SizedBox(height: 30),
          TextField(
            controller: _location,
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ],
      ),
    );
  }
}
