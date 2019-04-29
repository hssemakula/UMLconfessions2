import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'ReportPostDialog.dart';
import 'Themer.dart';
import 'ViewCommentsScreen.dart';
import 'package:umlconfessions/Home.dart';
import 'package:location/location.dart';

/*This is the class for the layout of an individual confession.
* Front End by Hillary Ssemakula, Back End by Michael Moschella*/

class ConfessionDesign extends StatefulWidget {
  String userName;
  String confessionText;
  String votes;
  bool isBookmarked;
  String avatarPath;
  String timePassed;
  String numOfComments;
  DataSnapshot snapshot;
  String confessionID;
  String email;
  String userID;
  String currentUsername;
  String currentUserEmail;
  String currentUserID;
  String imgURL;
  BuildContext context;

  ConfessionDesign(
      this.userName,
      this.confessionText,
      this.votes,
      this.isBookmarked,
      this.avatarPath,
      this.timePassed,
      this.numOfComments,
      this.snapshot,
      this.confessionID,
      this.email,
      this.userID,
      this.currentUsername,
      this.currentUserEmail,
      this.currentUserID,
      this.imgURL,
      context);

  @override
  ConfessionDesignState createState() => new ConfessionDesignState();
}

class ConfessionDesignState extends State<ConfessionDesign> {
  String myUserName = "Jane Doe";

  static Future<LocationData> getLoc() async {
    var currentLocation;
    try {
      currentLocation = await HomeState.loc.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  Future<int> decrementPostNum(String email) async {

    var snap;

    // DatabaseReference rrr = FirebaseDatabase.instance.reference().child("the_users").child(email).push();

    // DatabaseReference rr = FirebaseDatabase.instance.reference().child("the_users").child(email).child("postNum").push();


    await FirebaseDatabase.instance.reference().child("the_users").child(email).once().then((DataSnapshot snaps){
      snap = snaps;
    });

    var iop = snap.value.remove("postNum");
    int t = iop-1;
    snap.value.putIfAbsent("postNum", () => t);





    FirebaseDatabase.instance.reference().child("the_users").child(email).child("postNum").set(t);


    return t;
  }

  Future<int> decrementKarma(String email) async {

    var snap;

    // DatabaseReference rrr = FirebaseDatabase.instance.reference().child("the_users").child(email).push();

    // DatabaseReference rr = FirebaseDatabase.instance.reference().child("the_users").child(email).child("postNum").push();


    await FirebaseDatabase.instance.reference().child("the_users").child(email).once().then((DataSnapshot snaps){
      snap = snaps;
    });

    var iop = snap.value.remove("karma");
    int t = iop-1;
    snap.value.putIfAbsent("karma", () => t);




    FirebaseDatabase.instance.reference().child("the_users").child(email).child("karma").set(t);


    return t;
  }

  Future<int> incrementKarma(String email) async {

    var snap;

    // DatabaseReference rrr = FirebaseDatabase.instance.reference().child("the_users").child(email).push();

    // DatabaseReference rr = FirebaseDatabase.instance.reference().child("the_users").child(email).child("postNum").push();


    await FirebaseDatabase.instance.reference().child("the_users").child(email).once().then((DataSnapshot snaps){
      snap = snaps;
    });

    var iop = snap.value.remove("karma");
    int t = iop+1;
    snap.value.putIfAbsent("karma", () => t);





    FirebaseDatabase.instance.reference().child("the_users").child(email).child("karma").set(t);


    return t;
  }

  //This method designs the confession and how it looks like
  Widget build(BuildContext context) {
    //This method, when passed the user name of currectly signed user, either draws the delete icon or not.
    List<Widget> isUser_DisplayFlag(String signedInUser) {
      var buttonList = <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewCommentsPage(
                      widget.userName,
                      widget.confessionText,
                      widget.votes,
                      widget.isBookmarked,
                      widget.avatarPath,
                      widget.timePassed,
                      widget.numOfComments,
                      widget.snapshot,
                      widget.confessionID,
                      widget.email,
                      widget.userID,
                      widget.currentUsername,
                      widget.currentUserEmail,
                      widget.currentUserID,
                      context)),
            );
          },
          child: Stack(
            //comment button and text Stack to push them together
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                width: 30,
                child: Icon(
                  OMIcons.chat,
                  size: 18,
                  //check if dark theme change color
                  color:
                      Themer.setColor(context, Colors.black38, Colors.white70),
                ),
              ),
              Positioned(
                left: 20,
                child: Text(widget.numOfComments,
                    style: TextStyle(
                      fontSize: 14,
                      //check if dark theme change color
                      color: Themer.setColor(
                          context, Colors.black38, Colors.white70),
                    )),
              ),
            ],
          ),
        ),

        //report icon
        IconButton(
            icon: Icon(
              OMIcons.flag,
              size: 18,
              //check if dark theme change color
              color: Themer.setColor(context, Colors.black38, Colors.white70),
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

                                //Increments the flag count on a confession node
                                // in firebase - Michael Moschella


                                Navigator.pop(context);
                                var iop =
                                widget.snapshot.value.remove("Flags");
                                if(iop==null){
                                  iop=0;
                                }
                                int t = iop + 1;
                                widget.snapshot.value
                                    .putIfAbsent("Flags", () => iop);

                                FirebaseDatabase.instance
                                    .reference()
                                    .child("confessions")
                                    .child(widget.confessionID)
                                    .child("Flags")
                                    .set(t);

                                Fluttertoast.showToast(
                                  msg: "Your Feedback has been sent!  We will review this post.",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                );

                                getLoc().then((value) {
                                  setState(() {
                                    HomeState.locationNow = value;
                                  });
//42.665634, -71.384551
//42.608515, -71.270244
                                  if (HomeState.locationNow.longitude <  -71.270244 && HomeState.locationNow.longitude > -71.384551 && HomeState.locationNow.latitude <  42.665634 && HomeState.locationNow.latitude > 42.608515 ){
                                    Fluttertoast.showToast(
                                      msg: "You are in Lowell.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "You are not in Lowell.  In a release version of this app, you would not be able to perform this action without being there.",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                    );
                                  }
                                });


                              },
                              child: Text("SEND"),
                            ),
                            FlatButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                "CANCEL",
                                style: TextStyle(
                                    color: Themer.setColor(context,
                                        Colors.black54, Colors.white70)),
                              ),
                            )
                          ],
                          content: Container(
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width - 40,
                              child: ReportPostDialog(widget.confessionID))),
                    );
                  });
            }),
        IconButton(
          icon: Icon(
            OMIcons.delete,
            size: 17,
            //check if dark theme change color
            color: Themer.setColor(context, Colors.black38, Colors.white70),
          ),
          onPressed: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Delete confession?"),
                    content: SingleChildScrollView(
                      child: Text(
                          "Are you sure? This confession can't be recovered after it is deleted"),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          //LOG OUT CODE HERE
                        },
                        child: Text(
                          "DELETE",
                          style: TextStyle(
                              color: Themer.setColor(
                                  context, Colors.blueAccent, Colors.white)),
                        ),
                      ),
                      FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                              color: Themer.setColor(
                                  context, Colors.black54, Colors.white70)),
                        ),
                      ),
                    ],
                  );
                });
          },
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
                  //check if dark theme change color
                  color:
                      Themer.setColor(context, Colors.black38, Colors.white70),
                  size: 18,
                ),
          onPressed: () {},
        ),
      ];

      if (signedInUser != widget.userName) {
        buttonList.removeAt(2);
      }
      return buttonList;
    }

    return Padding(
        padding: EdgeInsets.all(10),
        //very important to make up and down vote column strect to height of confession text otherwise it stick to top.
        child: IntrinsicHeight(
          child: Row(
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
                            //check if dark theme change color
                            color: Themer.setColor(
                                context, Colors.black38, Colors.white70),
                          )),
                      Container(
                        //TIME PASSED
                        child: Text(
                          widget.timePassed,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            //check if dark theme change color
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewCommentsPage(
                                        widget.userName,
                                        widget.confessionText,
                                        widget.votes,
                                        widget.isBookmarked,
                                        widget.avatarPath,
                                        widget.timePassed,
                                        widget.numOfComments,
                                        widget.snapshot,
                                        widget.confessionID,
                                        widget.email,
                                        widget.userID,
                                        widget.currentUsername,
                                        widget.currentUserEmail,
                                        widget.currentUserID,
                                        context)),
                              );
                            },
                            child: Container(
                                //CONFESSION TEXT AND/OR PICTURE----------------------------------------------
                                margin: EdgeInsets.only(top: 3),
                                //make width 140 pixels less that screen width
                                width: MediaQuery.of(context).size.width - 140,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.confessionText,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: 16, height: 1.2),
                                      ),
                                      widget.imgURL ==
                                              "null" //if post has no picture, replace picture container with dummy
                                          ? Container(
                                              height: 0,
                                              width: 0,
                                              margin: EdgeInsets.all(0),
                                              padding: EdgeInsets.all(0),
                                            )
                                          : Container(
                                              height: 300,
                                              margin: EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                //make border round.
                                                border: Border.all(
                                                    width: 1,
                                                    color: Themer.setColor(
                                                        context,
                                                        Colors.black12,
                                                        null)),
                                              ),
                                              child: new ClipRRect(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        10.0),
                                                //explicitly make picture border round
                                                child: Image.network(
                                                  widget.imgURL,
                                                  fit: BoxFit.cover,
                                                ),
                                              ), /*Image.network(
                                                widget.imgURL,
                                                fit: BoxFit.cover,
                                              ) */
                                            ),
                                    ]))),

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
                                //THIS IS THE CODE FOR WHAT HAPPENS WHEN YOU UPVOTE.
                                //IT CHANGES THE VALUE IN FIREBASE TO THE VALUE +1
                                //MADE BY MICHAEL MOSCHELLA
                                onTap: () {

                                  Fluttertoast.showToast(
                                    msg: "Upvote",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                  );

                                  getLoc().then((value) {
                                    setState(() {
                                      HomeState.locationNow = value;
                                    });
//42.665634, -71.384551
//42.608515, -71.270244
                                    if (HomeState.locationNow.longitude <  -71.270244 && HomeState.locationNow.longitude > -71.384551 && HomeState.locationNow.latitude <  42.665634 && HomeState.locationNow.latitude > 42.608515 ){
                                      Fluttertoast.showToast(
                                        msg: "You are in Lowell.",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                      );
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "You are not in Lowell.  In a release version of this app, you would not be able to perform this action without being there.",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                      );
                                    }
                                  });


                                  var iop =
                                      widget.snapshot.value.remove("likeCount");
                                  int t = iop + 1;
                                  widget.snapshot.value
                                      .putIfAbsent("likeCount", () => iop);

                                  FirebaseDatabase.instance
                                      .reference()
                                      .child("confessions")
                                      .child(widget.confessionID)
                                      .child("likeCount")
                                      .set(t);
                                  var iol =
                                      widget.snapshot.value.remove("likeCount");
                                  widget.snapshot.value
                                      .putIfAbsent("likeCount", () => iol);

                                  String gg = widget.email;

                                  gg = gg.replaceAll(".",",");


                                  var aaa = incrementKarma(gg);

                                  if (iol < -4) {


                                    String gg = widget.email;

                                    String ff = gg.replaceAll(".",",");



                                    var aaa = decrementPostNum(ff);


                                    FirebaseDatabase.instance
                                        .reference()
                                        .child("confessions")
                                        .child(widget.confessionID)
                                        .set(null);


                                  }
                                },
                              ),
                              Text(widget.votes),
                              Container(
                                child: InkWell(
                                  child: Icon(Icons.expand_more,
                                      color: Color(0xFF0072bc), size: 35),
                                  //THIS IS THE CODE FOR WHAT HAPPENS WHEN YOU DOWNVOTE.
                                  //IT CHANGES THE VALUE IN FIREBASE TO THE VALUE -1
                                  //IT WILL ALSO DELETE THE POST IF THE VALUE IS LESS THAN -4
                                  //MADE BY MICHAEL MOSCHELLA
                                  onTap: () {
                                    Fluttertoast.showToast(
                                      msg: "Downvote",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                    );

                                    getLoc().then((value) {
                                      setState(() {
                                        HomeState.locationNow = value;
                                      });
//42.665634, -71.384551
//42.608515, -71.270244
                                      if (HomeState.locationNow.longitude <  -71.270244 && HomeState.locationNow.longitude > -71.384551 && HomeState.locationNow.latitude <  42.665634 && HomeState.locationNow.latitude > 42.608515 ){
                                        Fluttertoast.showToast(
                                          msg: "You are in Lowell.",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: "You are not in Lowell.  In a release version of this app, you would not be able to perform this action without being there.",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                        );
                                      }
                                    });

                                    var iop = widget.snapshot.value
                                        .remove("likeCount");
                                    int t = iop - 1;
                                    widget.snapshot.value
                                        .putIfAbsent("likeCount", () => iop);

                                    FirebaseDatabase.instance
                                        .reference()
                                        .child("confessions")
                                        .child(widget.confessionID)
                                        .child("likeCount")
                                        .set(t);
                                    var iol = widget.snapshot.value
                                        .remove("likeCount");
                                    widget.snapshot.value
                                        .putIfAbsent("likeCount", () => iol);

                                    String gg = widget.email;

                                    gg = gg.replaceAll(".",",");


                                    var aaa = decrementKarma(gg);
                                    if (iol < -3) {
                                      String gg = widget.email;

                                      gg = gg.replaceAll(".",",");



                                      var aaa = decrementPostNum(gg);

                                      FirebaseDatabase.instance
                                          .reference()
                                          .child("confessions")
                                          .child(widget.confessionID)
                                          .set(null);


                                    }
                                  },
                                ),
                                margin: EdgeInsets.only(top: 3),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  //BOOKMARKS, VIEW COMMENTS, REPORT ROW.----------------------------------------------------------------------
                  Container(
                      width: MediaQuery.of(context).size.width - 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: isUser_DisplayFlag(myUserName),
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
