import 'package:coach_link/Views/StartPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coach_link/Model/UpdateUser.dart';

class OnboardingPage extends StatefulWidget {
  String uid = "";
  OnboardingPage({Key? key, required this.uid}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  String uid = "";
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 10,
      vsync: this,
    );
  }

  ActionCodeSettings acs = ActionCodeSettings(
    handleCodeInApp: true,
    url: "package:coach_link/Web/index.html",
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<DropdownMenuItem<String>> options = <String>[
    'One',
    'Two',
    'Free',
    'Four'
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

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
                _createPageDropdown(
                    "What sport are you interested in coaching?",
                    _createDropdown(options, "One")),
                _createPageDropdown("What is your coaching specialty?",
                    _createDropdown(options, "One")),
                _createPageFillInBlank("What coaching experience do you have?"),
                _createPageFillInBlank(
                    "Do you have any awards and achievements you would like to list?"),
                _createPageFillInBlank("What college did you attend?"),
                _createPageFillInBlank("What degree did you get?"),
                _createPageFillInBlank("What High School did you attend?"),
                _createPageFillInBlank("What is your current location?"),
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
            style: TextStyle(fontSize: 28, color: Colors.black)),
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
              style: TextStyle(fontSize: 28, color: Colors.black)),
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
            },
            child: const Text('Go to App'),
          ),
        ],
      ),
    );
  }

  Container _createPageDropdown(
      String question, DropdownButton<String> dropdown) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(question,
              style: const TextStyle(fontSize: 32, color: Colors.black)),
          const SizedBox(height: 30),
          dropdown,
        ],
      ),
    );
  }

  Container _createPageFillInBlank(String question) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(question,
              style: const TextStyle(fontSize: 32, color: Colors.black)),
          const SizedBox(height: 30),
          const TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ],
      ),
    );
  }

  DropdownButton<String> _createDropdown(
      List<DropdownMenuItem<String>>? options, String startingValue) {
    return DropdownButton<String>(
        value: startingValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        onChanged: (String? newValue) {
          setState(() {
            startingValue = newValue!;
          });
        },
        items: options);
  }
}
