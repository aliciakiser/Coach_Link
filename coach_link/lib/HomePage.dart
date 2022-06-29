import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Widget _singlePostBody(int postID) {
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
                'assets/19602.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
                //backgroundImage: Image.asset('assets/images/image_1.jpg'),
                ),
            title: const Text("post title"),
            subtitle: const Text("post author"),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              "post description",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ButtonTheme(
            child: ButtonBar(
              children: <Widget>[
                TextButton(
                  child: Text('Like'.toUpperCase()),
                  onPressed: () {},
                ),
                TextButton(
                  child: Text('Read'.toUpperCase()),
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Coach Link"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _singlePostBody(1),
            _singlePostBody(2),
            _singlePostBody(3)
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
