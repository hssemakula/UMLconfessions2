import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'ConfessionDesign.dart';
import 'CurrentUser.dart';

/*This is the class for the bookmarks page.  Created by Hillary Ssemakula*/
class Bookmarks extends StatefulWidget {
  @override
  BookmarksState createState() => new BookmarksState();
}

class BookmarksState extends State<Bookmarks> {
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
        query: FirebaseDatabase.instance
            .reference()
            .child("confessions")
            .orderByChild("negative_time"),
        itemBuilder:
            (_, DataSnapshot snapshot, Animation<double> animation, int x) {
          if ((x % 2) == 1) {
            return ConfessionDesign(
                tagMake(snapshot),
                textMake(snapshot),
                likeCountMake(snapshot),
                x % 2 == 0 ? false : true,
                "assets/images/woman.png",
                "20m",
                commentCountMake(snapshot),
                snapshot,
                confessionIDMake(snapshot),
                emailMake(snapshot),
                userIDMake(snapshot),
                CurrentUser.usernameMain.text,
                CurrentUser.emailMain.text,
                CurrentUser.userIDMain,
                imgURLMake(snapshot),
                context);
          } else
            return Divider();
        });
    ;
  }

  //gets the comment Count of a post directly from the datasnapshot - Michael Moschella
  String commentCountMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("commentCount");
    String t = iop.toString();
    snapshot.value.putIfAbsent("commentCount", () => iop);
    return t;
  }

  //gets the ID of a post directly from the datasnapshot - Michael Moschella
  String confessionIDMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("confessionID");
    String t = iop.toString();
    snapshot.value.putIfAbsent("confessionID", () => iop);
    return t;
  }

  //gets the email of a post directly from the datasnapshot - Michael Moschella
  String emailMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("userInfo");
    var d = iop;
    var r = d.remove("email_address");
    String t = r.toString();
    d.putIfAbsent("email_address", () => r);
    snapshot.value.putIfAbsent("userInfo", () => iop);
    return t;
  }

  String userIDMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("userInfo");
    var d = iop;
    var r = d.remove("user_ID");
    String t = r.toString();
    d.putIfAbsent("user_ID", () => r);
    snapshot.value.putIfAbsent("userInfo", () => iop);
    return t;
  }

  //gets the text of a post directly from the datasnapshot - Michael Moschella
  String textMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("confessionText");
    String t = iop.toString();
    snapshot.value.putIfAbsent("confessionText", () => iop);
    return t;
  }

  String imgURLMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("imgURL");
    String t = iop.toString();
    snapshot.value.putIfAbsent("imgURL", () => iop);
    return t;
  }

  String tagMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("userInfo");
    var d = iop;
    var r = d.remove("userInfo");
    String t = r.toString();
    d.putIfAbsent("userInfo", () => r);
    snapshot.value.putIfAbsent("userInfo", () => iop);
    return t;
  }

  //gets the like count of a post directly from the datasnapshot - Michael Moschella
  String likeCountMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("likeCount");
    String t = iop.toString();
    snapshot.value.putIfAbsent("likeCount", () => iop);
    return t;
  }
}
