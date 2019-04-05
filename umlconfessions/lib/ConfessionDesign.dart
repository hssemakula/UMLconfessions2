import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'ViewCommentsScreen.dart';
import 'Themer.dart';

class ConfessionDesign extends StatefulWidget {
  String userName;
  String confessionText;
  String votes;
  bool isBookmarked;
  String avatarPath;
  String timePassed;
  String numOfComments;
  BuildContext context;

  ConfessionDesign(
      this.userName,
      this.confessionText,
      this.votes,
      this.isBookmarked,
      this.avatarPath,
      this.timePassed,
      this.numOfComments,
      context);

  @override
  ConfessionDesignState createState() => new ConfessionDesignState();
}

class ConfessionDesignState extends State<ConfessionDesign> {
  //This method designs the confession and how it looks like
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        //very important to make up and down vote column strect to height of confession text otherwise it stick to top.
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width * .13,
                width: MediaQuery.of(context).size.width * .13,
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
                                        context)),
                              );
                            },
                            child: Container(
                              //CONFESSION TEXT
                              margin: EdgeInsets.only(top: 3),
                              //make width 140 pixels less that screen width
                              width: MediaQuery.of(context).size.width - 140,
                              child: Text(
                                widget.confessionText,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
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

                  //BOOKMARKS, VIEW COMMENTS, REPORT ROW.----------------------------------------------------------------------
                  Container(
                    width: MediaQuery.of(context).size.width - 140,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          //comment button and text Row
                          children: <Widget>[
                            IconButton(
                              padding: EdgeInsets.only(left: 0),
                              icon: Icon(
                                OMIcons.chat,
                                size: 18,
                                //check if dark theme change color
                                color: Themer.setColor(
                                    context, Colors.black38, Colors.white70),
                              ),
                              onPressed: () {
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
                                          context)),
                                );
                              },
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 20),
                              child: InkWell(
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
                                            context)),
                                  );
                                },
                                child: Text(widget.numOfComments,
                                    style: TextStyle(
                                      fontSize: 14,
                                      //check if dark theme change color
                                      color: Themer.setColor(context,
                                          Colors.black38, Colors.white70),
                                    )),
                              ),
                              margin: EdgeInsets.only(right: 10),
                            )
                          ],
                        ),

                        //report icon
                        IconButton(
                            icon: Icon(
                              OMIcons.flag,
                              size: 18,
                              //check if dark theme change color
                              color: Themer.setColor(
                                  context, Colors.black38, Colors.white70),
                            ),
                            onPressed: () {}),
                        IconButton(
                          icon: Icon(
                            OMIcons.delete,
                            size: 17,
                            //check if dark theme change color
                            color: Themer.setColor(
                                context, Colors.black38, Colors.white70),
                          ),
                          onPressed: () {},
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
                                  color: Themer.setColor(
                                      context, Colors.black38, Colors.white70),
                                  size: 18,
                                ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
    ;
  }
}
