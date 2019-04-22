import 'package:flutter/material.dart';
import 'Themer.dart';

/* This is the class for the editing accounts page.  Made by Hillary Ssemakula*/

class EditAccount extends StatefulWidget {
  String userEmail;
  String password;
  String userName;

  EditAccount(this.userEmail, this.password, this.userName);

  @override
  EditAccountState createState() => new EditAccountState();
}

class EditAccountState extends State<EditAccount> {
  @override
  Widget build(BuildContext context) {
    Color titleIconColor = Themer.setColor(context, Color(0xFF0072bc), null);
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: titleIconColor),
          title: Container(
            margin: EdgeInsets.only(left: 5),
            child: Text("Edit account",
                style: TextStyle(color: titleIconColor, fontSize: 18)),
          ),
          actions: <Widget>[
            FlatButton(
              padding: EdgeInsets.only(top: 4),
              child: Text("SAVE",
                  style: TextStyle(color: titleIconColor, fontSize: 18)),
              onPressed: () {},
            )
          ],
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 2),
      body: buildEditLayout(),
    );
  }

  Widget buildEditLayout() {
    Color themeColor = Themer.setColor(context, Colors.black54, Colors.white70);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 10, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //USERNAME
            Container(
              padding: EdgeInsets.only(left: 15, right: 10),
              height: 60,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Name",
                    style: TextStyle(
                        fontSize: 18,
                        color: themeColor,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 10),
              height: 60,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color:
                                Themer.setColor(context, Colors.black54, null)),
                        hintText: widget.userName),
                  )),
            ),

            //EMAIL
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 15, right: 10),
              height: 60,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email",
                    style: TextStyle(
                        fontSize: 18,
                        color: themeColor,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 10),
              height: 60,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color:
                                Themer.setColor(context, Colors.black54, null)),
                        hintText: widget.userEmail),
                  )),
            ),

            //PASSWORD
            Container(
              padding: EdgeInsets.only(left: 15, right: 10),
              margin: EdgeInsets.only(top: 10),
              height: 60,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password",
                    style: TextStyle(
                        fontSize: 18,
                        color: themeColor,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 10),
              height: 60,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color:
                                Themer.setColor(context, Colors.black54, null)),
                        hintText: obscureText(widget.password)),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  String obscureText(String password) {
    String obscurePwd = "";
    for (int i = 0; i < password.length; i++) {
      obscurePwd += "•";
    }
    return obscurePwd;
  }
}
