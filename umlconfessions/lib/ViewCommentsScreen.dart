import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:umlconfessions/FirebaseDatabaseUsage.dart';

import 'ReportPostDialog.dart';
import 'Themer.dart';

/*  This is the class that lets you see the comments of a specific post.
* Front End by Hillary Ssemakula
* Back end by Michael Moschella*/

class ViewCommentsPage extends StatefulWidget {
  String userName;

  String confessionText;

  String votes;

  bool isBookmarked;

  String avatarPath;

  String timePassed;

  String numOfComments;

  DataSnapshot snapshop;

  String confessionID;

  final String email;

  final String userID;

  final String currentUsername;
  final String currentUserEmail;
  final String currentUserID;

  BuildContext context;

  ViewCommentsPage(
      this.userName,
      this.confessionText,
      this.votes,
      this.isBookmarked,
      this.avatarPath,
      this.timePassed,
      this.numOfComments,
      this.snapshop,
      this.confessionID,
      this.email,
      this.userID,
      this.currentUsername,
      this.currentUserEmail,
      this.currentUserID,
      this.context);

  @override
  ViewCommentsPageState createState() => ViewCommentsPageState();
}

class ViewCommentsPageState extends State<ViewCommentsPage> {
  final commentsArray =
      <Widget>[]; //first item is the post followed by all of it's comments.

  final myController = TextEditingController();

  int count;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
              color: Themer.setColor(context, Colors.black, null)),
          title: Container(
            margin: EdgeInsets.only(left: 5),
            child: Text("Confession",
                style: TextStyle(
                    color: Themer.setColor(context, Colors.black, null),
                    fontSize: 18)),
          ),
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 2),

      //Body is stack. List is first widget. Then a column is placed on top of list and is pushed to the bottom left

      //This makes it stick to bottom and rise when keyboard is pressed.

      body: Stack(children: [
        buildCommentsAndConfessionList(),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            color: Theme.of(context).canvasColor,
            padding: EdgeInsets.all(0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Divider(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(maxHeight: 150),
                      width: MediaQuery.of(context).size.width - 80,
                      child: TextField(
                        controller: myController,

                        style: TextStyle(fontSize: 18),

                        autofocus: true,

                        maxLines: null,
                        //this makes textbox grow as user types.

                        decoration: InputDecoration.collapsed(
                            hintStyle: TextStyle(
                                color: Themer.setColor(
                                    context, Colors.black54, null)),
                            hintText: "Write a comment..."),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
//will create a comment using the current confession ID and set the text and user -Michael Moschella
                        FirebaseDatabaseUsage.createComment(widget.confessionID)
                            .then((String commentKey) {
                          FirebaseDatabaseUsage.commentText(commentKey,
                              myController.text, widget.confessionID);
                          FirebaseDatabaseUsage.createCommentUser(
                              widget.confessionID,
                              widget.currentUserEmail,
                              widget.currentUsername,
                              widget.currentUserID,
                              commentKey);
                        });

                        //set action for send button
                      },
                      icon: Icon(Icons.send),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget mainConfession() {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),

        //very important to make up and down vote column strect to height of confession text otherwise it stick to top.

        child: IntrinsicHeight(
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 55,
                  width: 55,
                  margin: EdgeInsets.only(left: 5, right: 10, top: 2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(widget.avatarPath),
                          fit: BoxFit.cover)),
                ),
                Column(
                  //MAIN COLUMN

                  mainAxisAlignment: MainAxisAlignment.start,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[
                    //USERNAME, TIME row ---------------------------------------------------------------------------

                    Row(
                      children: <Widget>[
                        Container(
                          //USER NAME

                          child: Text(
                            widget.userName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),

                          margin: EdgeInsets.only(bottom: 2),
                        ),
                        Container(
                          //dot between name and time

                          height: 5,

                          width: 5,

                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 5, right: 5),

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Themer.setColor(
                                context, Colors.black38, Colors.white70),
                          ),
                        ),
                        Container(
                          //TIME PASSED

                          child: Text(
                            widget.timePassed,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: Themer.setColor(
                                  context, Colors.black38, Colors.white70),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //CONFESSION TEXT and VOTES row.-------------------------------------------------------------------------

                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {},
                              child: Container(
                                //CONFESSION TEXT

                                margin: EdgeInsets.only(top: 3),

                                width: MediaQuery.of(context).size.width - 140,

                                //width of device - 140 pixels

                                child: Text(
                                  widget.confessionText,
                                  softWrap: true,
                                  maxLines: 30,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(fontSize: 16, height: 1.2),
                                ),
                              )),

                          //UPVOTE DOWNVOTE BUTTON

                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  child: Container(
                                    child: Icon(
                                      Icons.expand_less,
                                      color: Color(0xFF0072bc),
                                      size: 35,
                                    ),
                                    margin: EdgeInsets.only(bottom: 3),
                                  ),
                                  onTap: () {},
                                ),
                                Text(widget.votes),
                                Container(
                                  child: InkWell(
                                    child: Icon(Icons.expand_more,
                                        color: Color(0xFF0072bc), size: 35),
                                    onTap: () {},
                                  ),
                                  margin: EdgeInsets.only(top: 3),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.only(bottom: 10),
            ),

            //empty container for padding

            Divider(
              height: 0,
            ),

            // REPORT ROW.----------------------------------------------------------------------

            Container(
              width: MediaQuery.of(context).size.width - 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //report icon

                  Container(
                    margin: EdgeInsets.only(left: 55),
                    child: IconButton(
                        icon: Icon(
                          OMIcons.flag,
                          size: 18,
                          color: Themer.setColor(
                              context, Colors.black38, Colors.white70),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return Container(
                                  child: AlertDialog(
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () {
                                            //SEND FEEDBACK
                                          },
                                          child: Text("SEND"),
                                        ),
                                        FlatButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            "CANCEL",
                                            style: TextStyle(
                                                color: Themer.setColor(
                                                    context,
                                                    Colors.black54,
                                                    Colors.white70)),
                                          ),
                                        )
                                      ],
                                      content: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          child: ReportPostDialog(widget.confessionID))),
                                );
                              });
                        }),
                  ),

                  //Bookmark icon

                  IconButton(
                    icon: widget
                            .isBookmarked //if confession is book marked show red icon otherwise

                        ? Icon(
                            Icons.bookmark_border,
                            size: 17,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.bookmark_border,
                            color: Themer.setColor(
                                context, Colors.black38, Colors.white70),
                            size: 18,
                          ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  Widget buildComment(String userName, String commentText, String avatarPath,
      String timePassed, BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 70, right: 10, top: 10),

        //very important to make up and down vote column strect to height of confession text otherwise it stick to top.

        child: Container(
          margin: EdgeInsets.only(top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 40,
                width: 40,
                margin: EdgeInsets.only(left: 5, right: 10, top: 2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(avatarPath), fit: BoxFit.cover)),
              ),
              Column(
                //MAIN COLUMN
                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[
                  //USERNAME, TIME row ---------------------------------------------------------------------------

                  Row(
                    children: <Widget>[
                      Container(
                        //USER NAME

                        child: Text(
                          userName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),

                        margin: EdgeInsets.only(bottom: 2),
                      ),
                      Container(
                        //dot between name and time

                        height: 5,

                        width: 5,

                        margin: EdgeInsets.only(
                            top: 10, bottom: 10, left: 5, right: 5),

                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Themer.setColor(
                                context, Colors.black38, Colors.white70)),
                      ),
                      Container(
                        //TIME PASSED

                        child: Text(
                          timePassed,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: Themer.setColor(
                                  context, Colors.black38, Colors.white70)),
                        ),
                      ),
                    ],
                  ),

                  //COMMENT TEXT ROW.-------------------------------------------------------------------------

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        //CONFESSION TEXT

                        margin: EdgeInsets.only(top: 1),

                        width: MediaQuery.of(context).size.width - 155,

                        //width of device - 155 pixels. 155 becuase of larger left margin

                        child: Text(
                          commentText,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 100,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 16, height: 1.2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  //Build list of comments and confession

  Widget buildCommentsAndConfessionList() {
    Query q = FirebaseDatabase.instance
        .reference()
        .child("the_comments")
        .child(widget.confessionID);


//Uses a firebaseAnimatedList to get data for comments - Michael Moschella
    return FirebaseAnimatedList(
      query: q,
      itemBuilder:
          (context, DataSnapshot snaps, Animation<double> animation, int x) {
            if (q == null) return mainConfession();
        return Column(children: [
          x == 0 ? mainConfession() : Text(snaps.key.isEmpty.toString()),
          Divider(
            height: 0,
          ),
          buildComment(tagMake(snaps), textMake(snaps), "assets/images/man.png",
              "40m", this.context)
        ]);
      },
    );
  }

//gets the key of a post directly from the datasnapshot -Michael Moschella
  String commentKeyMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("ConfessionID");

    String t = iop.toString();

    snapshot.value.putIfAbsent("ConfessionID", () => iop);

    return t;
  }

//gets the text of a comment directly from the datasnapshot - Michael Moschella
  String textMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("comment_text");

    String t = iop.toString();

    snapshot.value.putIfAbsent("comment_text", () => iop);

    return t;
  }

  //gets the username of a user directly from the datasnapshot - Michael Moschella
  String tagMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("userInfo");
    var d = iop;
    var r = d.remove("userInfo");
    String t = r.toString();
    d.putIfAbsent("userInfo", () => r);
    snapshot.value.putIfAbsent("userInfo", () => iop);
    return t;
  }

//gets the text of a post directly from the datasnapshot - Michael Moschella
  String textMakeT(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("confessionText");

    String t = iop.toString();

    snapshot.value.putIfAbsent("confessionText", () => iop);

    return t;
  }
}
