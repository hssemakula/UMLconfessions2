import 'package:flutter/material.dart';
import 'WecomeScreen.dart';
import 'Home.dart';
import 'dart:async';
import 'CurrentUser.dart';
/*This is the class for the main functionality that starts when the user first opens the app.  Made by Hillary Ssemakula*/
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: bloc.darkThemeEnabled,
        initialData: false,
        builder: (context, snapshot) {
          return MaterialApp(
              // new
              home: WelcomeScreen(),
              theme: snapshot.data ? ThemeData.dark() : ThemeData.light(),
              routes: <String, WidgetBuilder>{
                '/welcomeScreen': (BuildContext context) => WelcomeScreen(),
                '/homeScreen': (BuildContext context) =>
                Home(
                    CurrentUser.usernameMain.text,
                    "assets/images/man.png",
                    0,
                    0,
                    CurrentUser.emailMain.text,
                    CurrentUser.accountPassword.text,
                    CurrentUser.fbUserMain,
                    CurrentUser.userIDMain)
              },
              debugShowCheckedModeBanner: false);
        });
  }
}

class Bloc {
  final _themeController = StreamController<bool>.broadcast();

  get changeTheme {
    return _themeController.sink.add;
  }

  get darkThemeEnabled => _themeController.stream;
}

final bloc = Bloc();
