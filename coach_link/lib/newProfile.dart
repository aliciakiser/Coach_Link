import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({Key? key}) : super(key: key);

  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  String _email = "";
  String _userName = "";
  String _password = "";
  bool _success = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void newUserAction() async {
    final UserCredential credential =
        (await _auth.createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    ));
    final User? user = credential.user;
    if (user != null) {
      _success = true;
      print("Creating new user success");
    } else {
      _success = false;
      print("Creating new user failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Reset Password"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 100),
            const Text(
              'Email',
              textAlign: TextAlign.left,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Please Enter Email Address',
                    hintText: 'Enter valid email id as abc@gmail.com'),
                //controller: userNameController,
                onChanged: (email) {
                  this._email = email;
                },
              ),
            ),
            const Text(
              'User Name',
              textAlign: TextAlign.left,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Please Enter Your User Name',
                    hintText:
                        'Please enter your user name, it should be unique and only include alphanumeric characters'),
                //controller: userNameController,
                onChanged: (userName) {
                  this._userName = userName;
                },
              ),
            ),
            const Text(
              'Password',
              textAlign: TextAlign.left,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Please Enter Your Password',
                    hintText:
                        'Please enter your password, it should more than 8 characters including at least one special character and one number'),
                //controller: userNameController,
                onChanged: (password) {
                  this._password = password;
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  newUserAction();
                },
                child: const Text(
                  'Create Account',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
