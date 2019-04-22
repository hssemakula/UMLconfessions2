import 'package:flutter/material.dart';
import 'package:umlconfessions/Home.dart';
/*This is the class for the bookmarks page.  Created by Hillary Ssemakula*/
class Bookmarks extends StatefulWidget {
  var confessionsArray;

  Bookmarks(this.confessionsArray);

  @override
  BookmarksState createState() => new BookmarksState();
}

class BookmarksState extends State<Bookmarks> {
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.confessionsArray.length,
      itemBuilder: (context, i) {
        //Need to test if bookmarked before returning but currently there is no Confessions object
        return widget.confessionsArray[i];
      },
    );
  }
}
