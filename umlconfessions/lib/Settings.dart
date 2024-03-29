import 'package:flutter/material.dart';
import 'main.dart';
import 'TermsOfService.dart';
import 'DeleteAccount.dart';
import 'Themer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'CurrentUser.dart';

/* This is the class for the settings page.  Made by Hillary Ssemakula
* Accessed by the bottom navaigation bar*/

class Settings extends StatefulWidget {
  String userEmail;
  String password;
  String userName;
  String profilePictureUrl;



  Settings(
      this.userEmail, this.password, this.userName, this.profilePictureUrl);

  @override
  SettingsState createState() => new SettingsState();
}

class SettingsState extends State<Settings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //signs user out of firebase user account then returns to the welcome screen
  // -Michael Moschella
     _sign_Out() async{

    await _auth.signOut().then((_){
      Navigator.of(context).pushNamedAndRemoveUntil('/welcomeScreen', (Route<dynamic> route) => false);


    });

    }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: bloc.darkThemeEnabled,
        //check dark theme if true turn switch on
        initialData: Theme.of(context).brightness == Brightness.dark,
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20, right: 10),
                  height: 60,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Dark mode",
                              style: TextStyle(fontSize: 20),
                            ),
                            Switch(
                              value: snapshot.data,
                              onChanged: bloc.changeTheme,
                            ),
                          ])),
                ),
                Divider(),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 10),
                    height: 60,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Terms of Service",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TermsOfService()),
                    );
                  },
                ),
                Divider(),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 10),
                    height: 60,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Delete account",
                          style: TextStyle(
                              fontSize: 20,
                              //check if  dark theme, change color
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black54,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DeleteAccount(
                              widget.userEmail,
                              widget.password,
                              widget.userName,
                              widget.profilePictureUrl)),
                    );
                  },
                ),
                Divider(),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 10),
                    height: 60,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Log out",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                  ),
                  onTap: () {
                    return showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Log out"),
                            content: SingleChildScrollView(
                              child: Text(
                                  "Are you sure? Logging out will remove all uml confessions data from this device."),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "CANCEL",
                                  style: TextStyle(
                                      color: Themer.setColor(context,
                                          Colors.black54, Colors.white70)),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  //LOG OUT CODE

                                  //signs the user out of their firebase account
                                  //- Michael Moschella
                                  _sign_Out();
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Themer.setColor(context,
                                          Colors.black54, Colors.white70)),
                                ),
                              )
                            ],
                          );
                        });
                  },
                ),
              ],
            ),
          );
        });
  }
}
