import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:random_string/random_string.dart';
import 'dart:math';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'ConfessionDesign.dart';
import 'AddConfessionDialog.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:umlconfessions/FirebaseDatabaseUsage.dart';
import 'ViewAccount.dart';
import 'package:umlconfessions/Update_Post.dart';
import 'Settings.dart';
import 'Bookmarks.dart';
import 'Themer.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Home extends StatefulWidget {
  String userName;
  String profilePictureUrl; //profile picture from firebae
  int karma; //karma value from firebase
  String userEmail;
  String userPassword;
  int numOfPosts;
  FirebaseUser fbu;
  String userID;
  FirebaseUser fbUser;
  Home(
      this.userName,
      this.profilePictureUrl, //profile picture from firebae
      this.karma,
      this.numOfPosts,
      this.userEmail,
      this.userPassword,
      this.fbu,
      this.userID);

  //might need, to store confessions)
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  int navIndex = 0; //keeps track of what menu is open
  int numOfConfessions = 16; //number of confessions user has from firebase
  String _confessionText = "Confession Text Here";
  StreamSubscription _subscriptionConfession;
  final confessionsArray = <Widget>[];
  var list;

  static SharedPreferences localStorage;
  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }

  @override
  void initState() {


    Future<Confession> myConfession =
        FirebaseFunctionality.getConfession("-LSu6ejqSX97jDn6UR1s");

    if (myConfession == null) {
      Fluttertoast.showToast(
        msg: "err",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }





   // FirebaseFunctionality.getConfession("-LSu6ejqSX97jDn6UR1s").then(_updateConfession);  //.catchError(handleError);


    /*.whenComplete(() => Fluttertoast.showToast(
      msg: "00",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    )); */
    FirebaseFunctionality.getConfessionStream(
            "-LSu6ejqSX97jDn6UR1s", _updateConfession)
        .then((StreamSubscription s) => _subscriptionConfession = s);
    super.initState();
  }



  @override
  void dispose() {
    if (_subscriptionConfession != null) {
      _subscriptionConfession.cancel();
    }
    super.dispose();
  }

  //UI
  @override
  Widget build(BuildContext context) {


    //This array contains the different screens to be displayed, each index corresponds to a specific nav index when nav icon is pressed.
    final bodyChildren = <Widget>[
      buildConfessionsList(),
      Account(
          widget.userEmail,
          widget.userPassword,
          widget.userName,
          widget.profilePictureUrl,
          widget.karma.toString(),
          widget.numOfPosts.toString()),
      Bookmarks(confessionsArray),
      Settings(widget.userEmail, widget.userPassword, widget.userName, widget.profilePictureUrl)
    ];

    //This array contains appbars and a specific index is chosen depending on nav icon selected.
    final appBarChildren = <Widget>[
      createAppBar(context, "Home"),
      null,
      createAppBar(context, "Bookmarks"),
      AppBar(
          title: Container(
            padding: EdgeInsets.only(left: 5),
            child: Text("Settings",
                //check if dark theme change color
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontSize: 18)),
          ),
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 1)
    ];

    //Actually draws on screen.
    return Scaffold(
      appBar: appBarChildren[navIndex],

      //screen corresponding to nav element selected, is chosen from array
      body: bodyChildren[navIndex],
      //if it is the home screen display floating action bar else show nothing
      floatingActionButton: navIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                // _createConfessionText();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddConfessionDialog(null, null, widget.userEmail, widget.userName, widget.userID),
                      fullscreenDialog: true),
                );
              },
              child: Icon(
                Icons.palette,
                color: Themer.setColor(context, Colors.white, Colors.black87),
              ),
              //check if dark theme change color
              backgroundColor: Themer.setColor(
                  context, Color(0x9B0072bc), Color(0x9BFfffff)),
              //: ,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
            )
          : null,
      bottomNavigationBar: BottomNavyBar(
          items: navItems,
          onItemSelected: (index) {
            return setState(() {
              navIndex = index;
            });
          }),
    );
  } //END OF BUILD METHOD.

  String textGenerate(String s) {
    list.add(s);
    return list;
  }

  //gets the text of a post directly from the datasnapshot
  String textMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("confessionText");
    String t = iop.toString();
    snapshot.value.putIfAbsent("confessionText", () => iop);
    return t;
  }
  //gets the ID of a post directly from the datasnapshot
  String confessionIDMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("confessionID");
    String t = iop.toString();
    snapshot.value.putIfAbsent("confessionID", () => iop);
    return t;
  }
//gets the comment Count of a post directly from the datasnapshot
  String commentCountMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("commentCount");
    String t = iop.toString();
    snapshot.value.putIfAbsent("commentCount", () => iop);
    return t;
  }
//gets the image url of a post directly from the datasnapshot
  String imgURLMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("imgURL");
    String t = iop.toString();
    snapshot.value.putIfAbsent("imgURL", () => iop);
    return t;
  }
//gets the like count of a post directly from the datasnapshot
  String likeCountMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("likeCount");
    String t = iop.toString();
    snapshot.value.putIfAbsent("likeCount", () => iop);
    return t;
  }
//gets the username of a post directly from the datasnapshot
  String tagMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("userInfo");
    var d = iop;
    var r = d.remove("userInfo");
    String t = r.toString();
    d.putIfAbsent("userInfo", () => r);
    snapshot.value.putIfAbsent("userInfo", () => iop);
    return t;
  }
//gets the email of a post directly from the datasnapshot
  String emailMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("userInfo");
    var d = iop;
    var r = d.remove("email_address");
    String t = r.toString();
    d.putIfAbsent("email_address", () => r);
    snapshot.value.putIfAbsent("userInfo", () => iop);
    return t;
  }
//gets the userID of a post directly from the datasnapshot
  String userIDMake(DataSnapshot snapshot) {
    var iop = snapshot.value.remove("userInfo");
    var d = iop;
    var r = d.remove("user_ID");
    String t = r.toString();
    d.putIfAbsent("user_ID", () => r);
    snapshot.value.putIfAbsent("userInfo", () => iop);
    return t;
  }

  _updateConfession(Confession value) {
    var confessionText = value.confessionText;
    setState(() {
      _confessionText = confessionText;
    });
  }

  //Build list of confessions
  Widget buildConfessionsList() {
    /*return new FutureBuilder<List<Confession>>(
      future: getAllConfessions(),//getConfessionsNewThing
      builder: (context, snapshot){
      if(!snapshot.hasData) return Container();
      List<Confession> conf = snapshot.data;
      return new ListView(
        children: conf.map((confes) => Text(confes.confessionText)).toList()
      );
    }
    );*/
    //[
    // return Flexible(

    //This is the code that shows the feed
    return FirebaseAnimatedList(
        query: FirebaseDatabase.instance
            .reference()
            .child("confessions")
            .orderByChild("negative_time"),

        //padding: new EdgeInsets.all(8.0),
        //reverse: false,
        itemBuilder:
            (_, DataSnapshot snapshot, Animation<double> animation, int x) {
          return new Column(children: [
            //GETS THE RELEVANT DATA FROM EACH DATASNAPSHOT IN THE FZIREBASE ANIMATED LIST
            ConfessionDesign(
                tagMake(snapshot),//_loginUser(),
                // randomString(Random().nextInt(100)),

                //textGenerate(FirebaseDatabase.instance
                //  .reference().child("confessions")),

                textMake(snapshot),
                //"$_confessionText",
                likeCountMake(snapshot),
                //randomNumeric(Random().nextInt(3)),

                x % 2 == 0 ? false : true,
                "assets/images/woman.png",
                "20m",
                commentCountMake(snapshot),
                snapshot,
                confessionIDMake(snapshot),
                emailMake(snapshot),
                userIDMake(snapshot),
                widget.userName,
                widget.userEmail,
                widget.userID,
                imgURLMake(snapshot),
                context),
            Divider()
          ]);

          /* return new ListTile(
                    subtitle: new Text(snapshot.value.remove("confessionText").toString()),
                  );*/
        });

    //  );

    return ListView.builder(
      itemBuilder: (context, i) {
        if (i >= confessionsArray.length) {
          for (int j = 0; j <= 1; j++) {
            // I removed the confession design and put in it's own class hence the object ConfessionDesign()
            confessionsArray.add(
              Column(children: [
                ConfessionDesign(
                    "Jane Doe",
                    // randomString(Random().nextInt(100)),

                    //textGenerate(FirebaseDatabase.instance
                    //  .reference().child("confessions")),

                    "$_confessionText",
                    randomNumeric(Random().nextInt(3)),
                    j % 2 == 0 ? false : true,
                    "assets/images/woman.png",
                    "20m",
                    "4",
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    context),
                Divider()
              ]),
            );
          }
        }
        return confessionsArray[i];
      },
    );
  }

  Widget createAppBar(BuildContext context, title) {
    return AppBar(
        title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 33,
                width: 33,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(widget.profilePictureUrl),
                        fit: BoxFit.cover)),
              ),
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(title,
                    style: TextStyle(
                        //check if dark theme change color
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontSize:
                            18)), //instead of title we have array, index 0(navIndex) is selected. This is the app bar title that corresponds to the first nav screen, etc
              )
            ]),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2);
  }

  //This array stores all nav icons. the Bottom navy function chooses one by index when you tap.
  final navItems = <BottomNavyBarItem>[
    BottomNavyBarItem(
      icon: Icon(Icons.apps),
      title: Text('Home'),
      activeColor: Color(0xFF0072bc),
    ),
    BottomNavyBarItem(
        icon: Icon(Icons.people),
        title: Text('Account'),
        activeColor: Color(0xFF0072bc)),
    BottomNavyBarItem(
        icon: Icon(Icons.bookmark),
        title: Text('Bookmarks'),
        activeColor: Color(0xFF0072bc)),
    BottomNavyBarItem(
        icon: Icon(Icons.settings),
        title: Text('Settings'),
        activeColor: Color(0xFF0072bc)),
  ];

  void _createConfessionText() {
    FirebaseDatabaseUsage.createPost().then((String postKey) {
      //FirebaseDatabaseUsage.doNothing().then((String postKey){
      _update(postKey);
    });
  }

  void _update(String postKey) {
    var v = MaterialPageRoute(
        //builder: (context) => new UpdatePostPage(postKey: postKey),

        builder: (context) => AddConfessionDialog(null, null, widget.userEmail, widget.userName, widget.userID),
        fullscreenDialog: true);
    Navigator.of(context).push(v);
  }
  String _loginUser() {
String val;
    _loginU().then((result) {
      print(result);
      setState(() {
        val = result;
      });
    });
    return val;
   }

  Future<String> _loginU() async {
    Completer<FirebaseUser> completer = new Completer<FirebaseUser>();
    FirebaseUser use =  await _auth.signInWithEmailAndPassword(

        email: widget.userEmail,

        password: widget.userPassword

    );

    completer.complete(use);
    if(use=null){
      Fluttertoast.showToast(
        msg: "ITS NULL",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    Fluttertoast.showToast(
      msg: use.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
    return use.displayName;
  }

  static Future<List<Confession>> getAllConfessions() async {
    //String confessionKey = await Preferences.getConfessionKey();

    Completer<Confession> completer = new Completer<Confession>();
    List<Confession> val = new List<Confession>();
    FirebaseDatabase.instance
        .reference()
        .child("confessions")
        .orderByKey()
        .once()
        .then((DataSnapshot snapshot) {
      var confession = new Confession.fromJson(snapshot.key, snapshot.value);
      completer.complete(confession);
      val.add(confession);
    });

    Completer<List<Confession>> c = new Completer<List<Confession>>();

    c.complete(val);

    return val;
  }
}

class Confession {
  final String key;
  String confessionText;

  Confession.fromJson(this.key, Map data) {
    confessionText = data['confessionText'];
    if (confessionText == null) {
      confessionText = '';
    }
  }
}

class FirebaseFunctionality {
  static Future<StreamSubscription<Event>> getConfessionStream(
      String confessionKey, void onData(Confession confession)) async {
    //String confessionKey = await Preferences.getConfessionKey();

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("confessions")
        .child(confessionKey)
        .onValue
        .listen((Event event) {
      var confession =
          new Confession.fromJson(event.snapshot.key, event.snapshot.value);
      onData(confession);
    });
    return subscription;
  }

  //Some of this code is unused. The unused code is a failed implementation of the posts feed
  static Future<Confession> getConfession(String confessionKey) async {
    //String confessionKey = await Preferences.getConfessionKey();

    Completer<Confession> completer = new Completer<Confession>();

    FirebaseDatabase.instance
        .reference()
        .child("confessions")
        .child(confessionKey)
        .once()
        .then((DataSnapshot snapshot) {
      var confession = new Confession.fromJson(snapshot.key, snapshot.value);
      completer.complete(confession);
    });

    return (completer.future);
  }
}

class Preferences {
  static const String USER_KEY = "userKey";

  static Future<String> getAccountKey() async {
    SharedPreferences share = await SharedPreferences.getInstance();
    String userKey = share.getString(USER_KEY);

    if (userKey == null) {
      userKey = "";
    }
    return userKey;
  }
}
