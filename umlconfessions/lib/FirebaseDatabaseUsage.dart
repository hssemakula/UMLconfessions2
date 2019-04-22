import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
/* This class contains some methods for getting info from and entering info into firebase
* Made by Michael Moschella*/

class FirebaseDatabaseUsage  {


  //this is for entering all the data ito the firebase confession node -Michael Moschella
  static Future<String> createPost() async {
    String postKey = await _getPostKey();

    DatabaseReference ref = FirebaseDatabase.instance.reference().child("confessions").child(postKey).push();

    String myStr=ref.key;

    int positive = _getCurrentDate();
    int neg = 0-positive;




    var post = <String, dynamic>{
      'commentCount' : 0,
      'confessionID' : myStr,
      'confessionText' : '',
      'likeCount': 0,
      'time_of_creation': positive,
      'negative_time': neg,

    };



    ref.set(post);
    myStr=ref.key;

    return ref.key;
  }

  //This is for entering all the user info into the firebase confession node - Michael Moschella
  static void createPostUser(String pstKey,String email, String username, String userID ) async {
    String postKey = await _getPostKey();

    FirebaseDatabase.instance.reference().child("confessions").child(pstKey).child("userInfo").child("active").set(true);
    FirebaseDatabase.instance.reference().child("confessions").child(pstKey).child("userInfo").child("email_address").set(email);
    FirebaseDatabase.instance.reference().child("confessions").child(pstKey).child("userInfo").child("userInfo").set(username);
    FirebaseDatabase.instance.reference().child("confessions").child(pstKey).child("userInfo").child("email_address").set(userID);



    int positive = _getCurrentDate();
    int neg = 0-positive;






  }


  //enter all the user info into the comment node in firebase - Michael Moschella
  static void createCommentUser(String pstKey,String email, String username, String userID, String commKey ) async {
    String postKey = await _getPostKey();

    FirebaseDatabase.instance.reference().child("the_comments").child(pstKey).child(commKey).child("userInfo").child("active").set(true);
    FirebaseDatabase.instance.reference().child("the_comments").child(pstKey).child(commKey).child("userInfo").child("email_address").set(email);
    FirebaseDatabase.instance.reference().child("the_comments").child(pstKey).child(commKey).child("userInfo").child("userInfo").set(username);
    FirebaseDatabase.instance.reference().child("the_comments").child(pstKey).child(commKey).child("userInfo").child("email_address").set(userID);



    int positive = _getCurrentDate();
    int neg = 0-positive;






  }


//enter the data for a comment node into firebase - Michael Moschella
  static Future<String> createComment(String pstKey) async {
    String commentKey = await _getPostKey();

    DatabaseReference ref = FirebaseDatabase.instance.reference().child("the_comments").child(pstKey).child(commentKey).push();

    String myStr=ref.key;

    int positive = _getCurrentDate();
    int neg = 0-positive;
 var snap;
    await FirebaseDatabase.instance.reference().child("confessions").child(pstKey).once().then((DataSnapshot snaps){
      snap = snaps;
    });

    var iop = snap.value.remove("commentCount");
    int t = iop+1;
    snap.value.putIfAbsent("commentCount", () => iop);



    FirebaseDatabase.instance.reference().child("confessions").child(pstKey).child("commentCount").set(t);


    var post = <String, dynamic>{
      'comment_text' : '',
      'id_from_comment' : myStr,
      'likeCount': 0,
      'time_of_creation': positive,
      'negative_time': neg,

    };



    ref.set(post);
    myStr=ref.key;

    return ref.key;
  }

  //enters the text data for a confession into firebase -Michael Moschella
  static Future<void> pullText(String postKey, String postText) async {
    //String postKey = await _getPostKey();

    return FirebaseDatabase.instance.reference().child("confessions").child(postKey).child("confessionText").set(postText);
  }

  //enters the text data for a comment into firebase - Michael Moschella
  static Future<void> commentText(String commentKey, String postText, String postKey) async {
    //String postKey = await _getPostKey();

    return FirebaseDatabase.instance.reference().child("the_comments").child(postKey).child(commentKey).child("comment_text").set(postText);
  }
//unused
  static Future<StreamSubscription<Event>> getTextStream(String postKey, void onData(String theText)) async {
    //String postKey = await _getPostKey;

    StreamSubscription<Event> subscription = FirebaseDatabase.instance.reference().child("confessions").child(postKey).child("confessionText").onValue.listen((Event event){
      String the_Text = event.snapshot.value as String;
      if(the_Text == null){
        the_Text = "";
      }
      onData(the_Text);
    });

    return subscription;
  }
//unused
  static Future<Query> queryPostText() async {
    //String UserKey = await _getUserKey();

    return FirebaseDatabase.instance.reference().child("confessions").orderByChild("confessionText");
  }
//unused
  static Future<String> _getPostKey() async {
    return '';
  }

  //finds all the confessions in the database - Michael Moschella
  static DatabaseReference findConfession() {
    return FirebaseDatabase.instance.reference().child("confessions");
  }



  static doNothing(){

  }

//returns the current date
  static int _getCurrentDate() {
    int date = new DateTime.now().millisecondsSinceEpoch;
    String str = date.toString();
    return date;
  }

}