import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class PostDesign {
  //This method designs the post and how it looks like
  Widget createPost(
      String userName,
      String postText,
      String votes,
      bool isBookmarked,
      String avatarPath,
      String timePassed,
      String numOfComments,
      BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        //very important to make up and down vote column strect to height of post text otherwise it stick to top.
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
                          shape: BoxShape.circle, color: Colors.black38),
                    ),
                    Container(
                      //TIME PASSED
                      child: Text(
                        timePassed,
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Colors.black38),
                      ),
                    ),
                  ],
                ),

                //POST TEXT and VOTES row.-------------------------------------------------------------------------
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        //POST TEXT
                        margin: EdgeInsets.only(top:3),
                        width: MediaQuery.of(context).size.width - 140,
                        //width of device - 140 pixels
                        child: Text(
                          postText,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 16, height: 1.2),
                        ),
                      ),

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
                            Text(votes),
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
                            padding: EdgeInsets.only(left:0),
                            icon: Icon(
                              OMIcons.chat,
                              size: 18,
                              color: Colors.black54,
                            ),
                            onPressed: () {},
                          ),
                          Container(
                            child: Text(
                              numOfComments,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
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
                            color: Colors.black54,
                          ),
                          onPressed: () {}),

                      //Bookmark icon
                      IconButton(
                        icon:
                            isBookmarked //if post is book marked show red icon otherwise
                                ? Icon(
                                    Icons.bookmark_border,
                                    size: 17,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.bookmark_border,
                                    color: Colors.black38,
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
        )));
  }
}
