import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coach_link/Model/UpdateUser.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({Key? key}) : super(key: key);

  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  String _email = "";
  String _firstName = "";
  String _lastName = "";
  String _password = "";
  String _confirmPassword = "";
  //String _specialization = "";
  ActionCodeSettings acs = ActionCodeSettings(
    handleCodeInApp: true,
    url: "package:coach_link/Web/index.html",
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;
  var acs_email = ActionCodeSettings(
      // URL you want to redirect back to. The domain (www.example.com) for this
      // URL must be whitelisted in the Firebase Console.
      url: 'https://www.example.com/finishSignUp?cartId=1234',
      // This must be true
      handleCodeInApp: true,
      iOSBundleId: 'com.example.ios',
      androidPackageName: 'com.example.android',
      // installIfNotAvailable
      androidInstallApp: true,
      // minimumVersion
      androidMinimumVersion: '12');

  void newUserAction() async {
    try {
      final UserCredential credential =
          (await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      ));
      final User? user = credential.user;
      if (user != null) {
        await UpdateUser(uid: user.uid)
            .newProfile(_firstName, _lastName, _email);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Successfully created account, please login."),
        ));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed create account, please try again."),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed create account, please try again."),
      ));
      print(e);
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
                  var emailAuth = email;
                  FirebaseAuth.instance
                      .sendSignInLinkToEmail(
                          email: emailAuth, actionCodeSettings: acs_email)
                      .catchError((onError) =>
                          print('Error sending email verification $onError'))
                      .then((value) =>
                          print('Successfully sent email verification'));
                },
              ),
            ),
            const Text(
              'First Name',
              textAlign: TextAlign.left,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Please Enter Your First Name',
                    hintText: 'Please enter your first name'),
                //controller: userNameController,
                onChanged: (firstName) {
                  this._firstName = firstName;
                },
              ),
            ),
            const Text(
              'Last Name',
              textAlign: TextAlign.left,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Please Enter Your Last Name',
                    hintText: 'Please enter your last name'),
                //controller: userNameController,
                onChanged: (lastName) {
                  this._lastName = lastName;
                },
              ),
            ),
            // const Text(
            //   'Specialization',
            //   textAlign: TextAlign.left,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 15),
            //   child: TextField(
            //     decoration: InputDecoration(
            //         border: OutlineInputBorder(),
            //         labelText: 'Please Enter Your Specialization',
            //         hintText: 'Please enter your specialization'),
            //     //controller: userNameController,
            //     onChanged: (specialization) {
            //       this._specialization = specialization;
            //     },
            //   ),
            // ),
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
