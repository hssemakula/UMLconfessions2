import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  final profilePicture = 'assets/images/logo.png'; //profile picture from firebae
  int karma = 100; //karma value from firebase
  int numOfPosts = 16; //number of posts user has from firebase
  var postsArray = <Widget>[]; //might need, to store posts
  int navIndex = 0; //keeps track of what menu is open

  //UI
  @override
  Widget build(BuildContext context) {
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
                  margin: EdgeInsets.only(left: 20),
                  child: titleChildren[navIndex], //instead of title we have array, index 0(navIndex) is selected. This is the app bar title that corresponds to the first nav screen, etc
                )
              ]),
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 2),
      body: bodyChildren[navIndex], //screen corresponding to nav element selected, is chosen from array
      bottomNavigationBar: BottomNavyBar(
          items: navItems,
          onItemSelected: (index) {
            return setState(() {
              navIndex = index;
            });
          }),
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

  //This array contains the different screens to be displayed, each index corresponds to a specific nav index when nav icon is pressed.
  final bodyChildren = <Widget>[
    Container(
      constraints: BoxConstraints.expand(),
      color: Colors.blue,
      child: Text("Home"),
    ),
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

  //This array contains appbar titles and a specific index is chosen depending on nav icon slected.
  final titleChildren = <Widget>[
    Text("Home", style: TextStyle(color: Colors.black, fontSize: 18)),
    Text("Profile", style: TextStyle(color: Colors.black, fontSize: 18)),
    Text("Bookmarks", style: TextStyle(color: Colors.black, fontSize: 18)),
    Text("Settings", style: TextStyle(color: Colors.black, fontSize: 18))
  ];
}
