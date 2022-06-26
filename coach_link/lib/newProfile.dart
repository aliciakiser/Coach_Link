import 'package:flutter/material.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({Key? key}) : super(key: key);

  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Please Enter Email Address',
                    hintText: 'Enter valid email id as abc@gmail.com'),
                //controller: userNameController,
              ),
            ),
            const Text(
              'User Name',
              textAlign: TextAlign.left,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Please Enter Your User Name',
                    hintText:
                        'Please enter your user name, it should be unique and only include alphanumeric characters'),
                //controller: userNameController,
              ),
            ),
            const Text(
              'Password',
              textAlign: TextAlign.left,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Please Enter Your Password',
                    hintText:
                        'Please enter your password, it should more than 8 characters including at least one special character and one number'),
                //controller: userNameController,
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
