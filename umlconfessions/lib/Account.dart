import 'package:flutter/material.dart';
import 'EditAccount.dart';

class Account extends StatefulWidget {
  String userEmail;
  String password;
  String userName;
  String profilePictureUrl;
  String karma;
  String numOfPosts;

  Account(this.userEmail, this.password, this.userName, this.profilePictureUrl,
      this.karma, this.numOfPosts);

  @override
  AccountState createState() => new AccountState();
}

class AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          //STACK TO make profile picture design. the picture is placed on top of colum which forms the blue, white color split.
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    color: Color(0xFF0072bc),
                    height: 165,
                  ),

                  //Container with edit button name and karma
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: Container(
                      color: Theme.of(context).canvasColor,
                      height: 150,
                      margin: EdgeInsets.only(top: 5),
                      child: Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                          OutlineButton(
                              borderSide: BorderSide(color: Colors.black54),
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditAccount(
                                          widget.userEmail,
                                          widget.password,
                                          widget.userName)),
                                );
                              })
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.userName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            )
                          ],
                        ),

                        //Number of posts and Karma row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    widget.karma + " ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                  Text("Karma",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 15))
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15, left: 30),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    widget.numOfPosts + " ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                  Text("Posts",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 15))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),

                  Divider(
                    height: 0,
                  )
                ],
              ),

              //PROFILE PICTURE
              Positioned(
                top: 122.5,
                left: 10,
                child: Container(
                  height: 85,
                  width: 85,
                  margin: EdgeInsets.only(left: 5, right: 10, top: 2),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).canvasColor, width: 4),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(widget.profilePictureUrl),
                          fit: BoxFit.cover)),
                ),
              ),
            ],
          ),

          //MAIN CONTENT.
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 15, right: 10),
                height: 60,
                color: Color(0x110072bc),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 10),
                height: 60,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.userName,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 10),
                height: 60,
                color: Color(0x110072bc),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 10),
                height: 60,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.userEmail,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 10),
                height: 60,
                color: Color(0x110072bc),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 10),
                height: 60,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      obscureText(widget.password),
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String obscureText(String password) {
  String obscurePwd = "";
  for (int i = 0; i < password.length; i++) {
    obscurePwd += "•";
  }
  return obscurePwd;
}
