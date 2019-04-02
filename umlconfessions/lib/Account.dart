import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  String userEmail;
  String password;
  String userName;
  String profilePictureUrl;
  String karma;
  String numOfPosts;

  Account(this.userEmail, this.password, this.userName, this.profilePictureUrl, this.karma, this.numOfPosts);

  @override
  AccountState createState() => new AccountState();
}

class AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                    height: 100,
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
                            onPressed: () {})
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.userName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          )
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(widget.karma),
                                Text("Karma")
                              ],
                            ),
                          ),
                          Container(),
                          Container(),
                        ],
                      ),
                    ]),
                  ),
                )
              ],
            ),
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
        )
      ],
    );
  }
}
