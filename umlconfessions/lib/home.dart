import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<Home> {
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
                        image: AssetImage(profilePicture), fit: BoxFit.cover)),
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
        body: Text("Posts List"));
  }
}
