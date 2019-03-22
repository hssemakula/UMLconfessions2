import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  final profilePicture = 'assets/images/logo.png'; //profile picture
  var karma = 100;
  var numOfPosts = 16;
  var postsArray = <Widget>[];

  //To be used to generate posts.
  Widget postsList() {
    return ListView.builder();
  }

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
                    child: Text(
                      "Home",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ))
              ]),
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 2),
      body: Text("Posts list"),
      bottomNavigationBar: ,
    );
  }
}

class BottomNavyBarHelper{
  int _index = 0;

  Widget build() {
    return BottomNavyBar(items: [
      BottomNavyBarItem(
        icon: Icon(Icons.apps),
        title: Text('Home'),
        activeColor: Colors.red,
      ),
      BottomNavyBarItem(
          icon: Icon(Icons.people),
          title: Text('Users'),
          activeColor: Colors.purpleAccent),
      BottomNavyBarItem(
          icon: Icon(Icons.message),
          title: Text('Messages'),
          activeColor: Colors.pink),
      BottomNavyBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
          activeColor: Colors.blue),
    ], onItemSelected: (index) {
      return setState(() {
          _index = index;
        });
    });
  }
}
