import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'Themer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

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
      this.context);

  @override
  ViewCommentsPageState createState() => ViewCommentsPageState();
}

class ViewCommentsPageState extends State<ViewCommentsPage> {
  final commentsArray =
      <Widget>[]; //first item is the post followed by all of it's comments.

  int count;

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
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(maxHeight: 150),
                    width: MediaQuery.of(context).size.width - 80,
                    child: TextField(
                      style: TextStyle(fontSize: 18),
                      autofocus: true,
                      maxLines: null, //this makes textbox grow as user types.
                      decoration: InputDecoration.collapsed(
                          hintStyle: TextStyle(
                              color: Themer.setColor(
                                  context, Colors.black54, null)),
                          hintText: "Write a comment..."),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      //set action for send button
                    },
                    icon: Icon(Icons.send),
                  )
                ],
              ),
            ),
          ]),
        ),
      ]),

      //ListView.builder(
      //itemBuilder: (context,i) {
      // if (i<1) {
      // return buildCommentsAndConfessionList();/*new Column(
      //children: <Widget>[
      // buildCommentsAndConfessionList(),

      //   ],

      // );*/

      //}

      //   }
      // )
    );
  }

  Widget mainConfession() {
    return Padding(
        padding: EdgeInsets.all(10),
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
              padding: EdgeInsets.only(bottom: 20),
            ),
            //empty container for padding
            Divider(
              height: 5,
            ),
            // REPORT ROW.----------------------------------------------------------------------
            Container(
              width: MediaQuery.of(context).size.width - 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //report icon
                  IconButton(
                      icon: Icon(
                        OMIcons.flag,
                        size: 18,
                        color: Themer.setColor(
                            context, Colors.black38, Colors.white70),
                      ),
                      onPressed: () {}),

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
        padding: EdgeInsets.only(left: 70, right: 10, top: 10, bottom: 10),
        //very important to make up and down vote column strect to height of confession text otherwise it stick to top.
        child: IntrinsicHeight(
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
              mainAxisAlignment: MainAxisAlignment.start,
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
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {},
                          child: Container(
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
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )));
  }

  //Build list of comments and confession
  Widget buildCommentsAndConfessionList() {
    // return ListView.builder(
    return FirebaseAnimatedList(
      query: FirebaseDatabase.instance
          .reference()
          .child("the_comments")
          .child(widget.confessionID),
//query: FirebaseDatabase.instance
//  .reference().child("confessions").orderByChild("negative_time"),
      itemBuilder:
          (context, DataSnapshot snaps, Animation<double> animation, int x) {
//  if (x.isOdd && x == 1)
//  return Divider(
//  height: 5,
//);
//else if (x.isOdd) return Divider();

//final index =
//  x ~/ 2; //counts number of confessions minus divider widget
//if (index >= commentsArray.length) {
//for (int j = 0; j <= 10; j++) {
// I removed the confession design and put in it's own class hence the object ConfessionDesign()
// commentsArray[0] = null;
// commentsArray.add(buildComment(textMakeT(snaps), "Some comment",
// "assets/images/man.png", "40m", this.context));

// commentsArray.add(buildComment(textMake(snaps), "Some comment",
//   "assets/images/man.png", "40m", this.context));
// }
// }
//commentsArray[0] = mainConfession();

        return buildComment("John Doe", textMake(snaps),
            "assets/images/man.png", "40m", this.context);
      },
    );
//);
  }

  String commentKeyMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("ConfessionID");
    String t = iop.toString();
    snapshot.value.putIfAbsent("ConfessionID", () => iop);
    return t;
  }

  String textMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("comment_text");
    String t = iop.toString();
    snapshot.value.putIfAbsent("comment_text", () => iop);
    return t;
  }

  String textMakeT(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("confessionText");
    String t = iop.toString();
    snapshot.value.putIfAbsent("confessionText", () => iop);
    return t;
  }
}

/*
return FirebaseAnimatedList(


              query: FirebaseDatabase.instance
                  .reference().child("confessions").orderByChild("negative_time"),


                //padding: new EdgeInsets.all(8.0),
                //reverse: false,
                itemBuilder: (_, DataSnapshot snapshot,
                    Animation<double> animation, int x) {
                return new
                  Column(
                      children: [ ConfessionDesign(
                          "Jane Doe",
                          // randomString(Random().nextInt(100)),

                          //textGenerate(FirebaseDatabase.instance
                          //  .reference().child("confessions")),






                          textMake(snapshot),//"$_confessionText",
                          likeCountMake(snapshot),//randomNumeric(Random().nextInt(3)),

                          x % 2 == 0 ? false : true,
                          "assets/images/woman.png",
                          "20m",
                          commentCountMake(snapshot),
                          context), Divider()]
                  );


                 /* return new ListTile(
                    subtitle: new Text(snapshot.value.remove("confessionText").toString()),
                  );*/
                }

            );
 */

/*
Widget buildCommentsAndConfessionList() {
   return ListView.builder(

      itemBuilder: (context, i) {
        if (i.isOdd && i == 1)
          return Divider(
            height: 5,
          );
        else if (i.isOdd) return Divider();

        final index =
            i ~/ 2; //counts number of confessions minus divider widget
        if (index >= commentsArray.length) {
          for (int j = 0; j <= 10; j++) {
            // I removed the confession design and put in it's own class hence the object ConfessionDesign()
            commentsArray.add(buildComment("John doe", "Some comment",
                "assets/images/man.png", "40m", this.context));
          }
        }
        commentsArray[0] = mainConfession();
        return commentsArray[index];
      },
    );
  }
}
 */
