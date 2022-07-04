import 'package:flutter/material.dart';
import 'SearchLandingPage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyword = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Coach Search"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 200),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Please Enter Your Search',
                    hintText: 'Enter your search'),
                //controller: userNameController,
                onChanged: (keyword) {
                  this.keyword = keyword;
                },
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchLandingPage(
                      keyword: keyword,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.black87,
                primary: Colors.blue,
                minimumSize: Size(50, 50),
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: const CircleBorder(),
              ),
              icon: Icon(Icons.search),
              label: Text(""),
            ),
          ],
        ),
      ),
    );
  }
}
