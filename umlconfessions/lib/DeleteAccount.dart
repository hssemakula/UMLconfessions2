import 'package:flutter/material.dart';
import 'Themer.dart';
/* This is the class for the deleting accounts page.  Made by Hillary Ssemakula*/
class DeleteAccount extends StatefulWidget {
  String userEmail;
  String password;
  String userName;
  String profilePictureUrl;

  DeleteAccount(
      this.userEmail, this.password, this.userName, this.profilePictureUrl);

  @override
  DeleteAccountState createState() => new DeleteAccountState();
}

class DeleteAccountState extends State<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    Color titleIconColor = Themer.setColor(context, Color(0xFF0072bc), null);
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: titleIconColor),
          title: Container(
            margin: EdgeInsets.only(left: 5),
            child: Text("Delete account",
                style: TextStyle(color: titleIconColor, fontSize: 18)),
          ),
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 2),
      body: buildDeleteLayout(),
    );
  }

  Widget buildDeleteLayout() {
    Color themeColor = Themer.setColor(context, Colors.black54, Colors.white70);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 10, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              margin: EdgeInsets.only(left: 5, right: 10, top: 2),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Themer.setColor(
                          context, Theme.of(context).canvasColor, null),
                      width: 4),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(widget.profilePictureUrl),
                      fit: BoxFit.cover)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                widget.userName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: themeColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                "This will delete your account",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold, height: 1.2),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 25, right: 20),
              child: Text(
                "You're about to delete your account. Your profile picture and your name will no longer appear on uml confessions",
                style: TextStyle(fontSize: 15, height: 1.2, color: themeColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                "Email and username              ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 25, right: 20),
              child: Text(
                "You will not be able to use your email address to register another account with uml confessions.",
                style: TextStyle(fontSize: 15, height: 1.2, color: themeColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50, bottom: 10),
              width: MediaQuery.of(context).size.width - 80,
              child: OutlineButton(
                padding: EdgeInsets.all(20),
                child: Text(
                  'DELETE ACCOUNT',
                  style: TextStyle(
                      color: Themer.setColor(context, Colors.red, null),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                splashColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  //DELETE ACCOUNT ACCOUNT HERE

                  //There is currently no way to delete Firebase users using Flutter
                  // check here for more on this issue: https://github.com/flutter/flutter/issues/15907
                  // - Michael Moschella
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
