import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:random_string/random_string.dart';
import 'dart:math';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'post_design.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  final userName = "John Doe";
  final profilePicture =
      'assets/images/logo.png'; //profile picture from firebae
  int karma = 100; //karma value from firebase
  int numOfPosts = 16; //number of posts user has from firebase
  final postsArray = <Widget>[]; //might need, to store posts
  int navIndex = 0; //keeps track of what menu is open

  String _confessionText = "Confession Text Here";
  StreamSubscription _subscriptionConfession;


  @override
  void initState() {
    Future<Confession> myConfession =
        FirebaseFunctionality.getConfession("-LSu6ejqSX97jDn6UR1s");

    if (myConfession == null) {
      Fluttertoast.showToast(
        msg: "err",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }

    /*FirebaseFunctionality.getConfession("-LSu6ejqSX97jDn6UR1s").then(_updateConfession);  //.catchError(handleError);
    Fluttertoast.showToast(
      msg: "0000000000000000",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    ).whenComplete(() => Fluttertoast.showToast(
      msg: "00",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    )); */
    FirebaseFunctionality.getConfessionStream(
            "-LSu6ejqSX97jDn6UR1s", _updateConfession)
        .then((StreamSubscription s) => _subscriptionConfession = s);
    super.initState();
  }

  @override
  void dispose() {
    if (_subscriptionConfession != null) {
      _subscriptionConfession.cancel();
    }
    super.dispose();
  }

  //UI
  @override
  Widget build(BuildContext context) {
    //This array contains the different screens to be displayed, each index corresponds to a specific nav index when nav icon is pressed.
    final bodyChildren = <Widget>[
      buildPostsList(),
      Container(
        constraints: BoxConstraints.expand(),
        color: Colors.greenAccent,
        child: Text("Profile"),
      ),
      Container(
        constraints: BoxConstraints.expand(),
        color: Colors.redAccent,
        child: Text("Bookmarks"),
      ),
      Container(
        constraints: BoxConstraints.expand(),
        color: Colors.amberAccent,
        child: Text("Settings"),
      )
    ];

    //Actually draws on screen.
    return Scaffold(
      appBar: AppBar(
          title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 33,
                  width: 33,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(profilePicture),
                          fit: BoxFit.cover)),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: titleChildren[
                      navIndex], //instead of title we have array, index 0(navIndex) is selected. This is the app bar title that corresponds to the first nav screen, etc
                )
              ]),
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 2),
      //screen corresponding to nav element selected, is chosen from array
      body: bodyChildren[navIndex],
      //if it is the home screen display floating action bar else show nothing
      floatingActionButton: navIndex == 0
          ? FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.palette,
              ),
              backgroundColor: Color(0x9B0072bc),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
            )
          : null,
      bottomNavigationBar: BottomNavyBar(
          items: navItems,
          onItemSelected: (index) {
            return setState(() {
              navIndex = index;
            });
          }),
    );
  } //END OF BUILD METHOD.

  _updateConfession(Confession value) {
    var confessionText = value.confessionText;
    setState(() {
      _confessionText = confessionText;
    });
  }

  //Build list of posts
  Widget buildPostsList() {
    return ListView.builder(
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2; //counts number of posts minus divider widget
        if (index >= postsArray.length) {
          for (int j = 0; j <= 10; j++) {
            // I removed the post design and put in it's own class hence the object PostDesign()
            postsArray.add(
              PostDesign().createPost(
                  "Jane Doe",
                  // randomString(Random().nextInt(100)),
                  "$_confessionText",
                  randomNumeric(Random().nextInt(3)),
                  j % 2 == 0 ? false : true,
                  "assets/images/woman.png",
                  "20m",
                  "4",
                  context),
            );
          }
        }
        return postsArray[index];
      },
    );
  }

  //This array stores all nav icons. the Bottom navy function chooses one by index when you tap.
  final navItems = <BottomNavyBarItem>[
    BottomNavyBarItem(
      icon: Icon(Icons.apps),
      title: Text('Home'),
      activeColor: Color(0xFF0072bc),
    ),
    BottomNavyBarItem(
        icon: Icon(Icons.people),
        title: Text('Profile'),
        activeColor: Color(0xFF0072bc)),
    BottomNavyBarItem(
        icon: Icon(Icons.bookmark),
        title: Text('Bookmarks'),
        activeColor: Color(0xFF0072bc)),
    BottomNavyBarItem(
        icon: Icon(Icons.settings),
        title: Text('Settings'),
        activeColor: Color(0xFF0072bc)),
  ];

  //This array contains appbar titles and a specific index is chosen depending on nav icon slected.
  final titleChildren = <Widget>[
    Text("Home", style: TextStyle(color: Colors.black, fontSize: 18)),
    Text("Profile", style: TextStyle(color: Colors.black, fontSize: 18)),
    Text("Bookmarks", style: TextStyle(color: Colors.black, fontSize: 18)),
    Text("Settings", style: TextStyle(color: Colors.black, fontSize: 18))
  ];
}

class Confession {
  final String key;
  String confessionText;

  Confession.fromJson(this.key, Map data) {
    confessionText = data['confessionText'];
    if (confessionText == null) {
      confessionText = '';
    }
  }
}

class FirebaseFunctionality {
  static Future<StreamSubscription<Event>> getConfessionStream(
      String confessionKey, void onData(Confession confession)) async {
    //String confessionKey = await Preferences.getConfessionKey();

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("confessions")
        .child(confessionKey)
        .onValue
        .listen((Event event) {
      var confession =
          new Confession.fromJson(event.snapshot.key, event.snapshot.value);
      onData(confession);
    });
    return subscription;
  }

  static Future<Confession> getConfession(String confessionKey) async {
    //String confessionKey = await Preferences.getConfessionKey();

    Completer<Confession> completer = new Completer<Confession>();

    FirebaseDatabase.instance
        .reference()
        .child("confessions")
        .child(confessionKey)
        .once()
        .then((DataSnapshot snapshot) {
      var confession = new Confession.fromJson(snapshot.key, snapshot.value);
      completer.complete(confession);
    });

    return (completer.future);
  }
}

class Preferences {
  static const String USER_KEY = "userKey";

  static Future<String> getAccountKey() async {
    SharedPreferences share = await SharedPreferences.getInstance();
    String userKey = share.getString(USER_KEY);

    if (userKey == null) {
      userKey = "";
    }
    return userKey;
  }
}
