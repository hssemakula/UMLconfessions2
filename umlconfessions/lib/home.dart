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
  int navIndex = 0;
  String appTitle = 'home';
  Widget bodyWidget; // acts like fragment, whenever nav is pressed, this is changed to settings, profile, etc

  //To be used to generate and show posts.
  Widget postsWidget() {
    //return ListView.builder(itemBuilder: ,);
    appTitle = "Home";
    return Text('Posts Here');
  }

  //To show profile screen
  Widget profileWidget(){
    appTitle = 'Profile';
    return Text("Profile Here");
  }
//bookmarks screen
  Widget bookmarksWidget(){
    appTitle = 'Bookmarks';
    return Text("Bookmarks Here");
  }

  //settings screen
  Widget settingsWidget(){
    appTitle = 'Settings';
    return Text("Settings Here");
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
                        appTitle,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ))
                ]),
            backgroundColor: Theme.of(context).canvasColor,
            elevation: 2),
        body: postsWidget(),
        
        
        bottomNavigationBar:  BottomNavyBar(
              items: navItems,
              onItemSelected: (index) {
                return setState(() {
                  navIndex = index;
                  switch(index){
                    case 0: bodyWidget = postsWidget();
                    break;
                    case 1: bodyWidget = profileWidget();
                    break;
                    case 2: bodyWidget = bookmarksWidget();
                    break;
                    case 3: bodyWidget = settingsWidget();
                    break;
                  }
                });
              }),
        );
  }
}

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
