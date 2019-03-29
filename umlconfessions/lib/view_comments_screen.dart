import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class ViewCommentsPage extends StatefulWidget {
  @override
  ViewCommentsPageState createState() => ViewCommentsPageState();
}

class ViewCommentsPageState extends State<ViewCommentsPage> {
  final commentsArray = <Widget>[]; //first item is the post followed by all of it's comments.


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Container(
            margin: EdgeInsets.only(left: 30),
            child: Text("Confession",
                style: TextStyle(color: Colors.black, fontSize: 18)),
          ),
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 2),
    );
  }

}
