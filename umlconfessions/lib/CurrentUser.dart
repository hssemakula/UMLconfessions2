import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
/* This is the class that contains the user as well as the info for the current user.
* Made by Hillary Ssemakula*/
class CurrentUser extends StatefulWidget {
  @override
  CurrentUserState createState() => new CurrentUserState();

  static FirebaseUser fbUserMain;
  static TextEditingController usernameMain = new TextEditingController();
  static TextEditingController  emailMain = new TextEditingController();
  static String userIDMain = "";
  static TextEditingController accountPassword = new TextEditingController();
}

class CurrentUserState extends State<CurrentUser> {
  @override
  Widget build(BuildContext context) {
    return Container(color: const Color(0xFFFFE306));
  }
}
