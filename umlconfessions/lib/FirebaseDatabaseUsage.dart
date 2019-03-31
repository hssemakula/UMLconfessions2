import 'package:intl/intl.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';


class FirebaseDatabaseUsage  {

  static Future<String> createPost() async {
    String postKey = await _getPostKey();

    DatabaseReference ref = FirebaseDatabase.instance.reference().child("confessions").child(postKey).push();

    String myStr=ref.key;


    var post = <String, dynamic>{
      'commentCount' : 0,
      'confessionID' : myStr,
      'confessionText' : '',
      'likeCount': 0,
      'time_of_creation': _getCurrentDate(),

    };



    ref.set(post);
    myStr=ref.key;

    return ref.key;
  }

  static Future<void> pullText(String postKey, String postText) async {
    //String postKey = await _getPostKey();

    return FirebaseDatabase.instance.reference().child("confessions").child(postKey).child("confessionText").set(postText);
  }

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

  static Future<Query> queryPostText() async {
    //String UserKey = await _getUserKey();

    return FirebaseDatabase.instance.reference().child("confessions").orderByChild("confessionText");
  }

  static Future<String> _getPostKey() async {
    return '';
  }

  static doNothing(){

  }


  static String _getCurrentDate() {
    var date = new DateTime.now().millisecondsSinceEpoch;
    String str = date.toString();
    return str;
  }

}