import 'package:flutter/material.dart';
import 'WecomeScreen.dart';
import 'Home.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // new
        home: WelcomeScreen(),
        routes: <String, WidgetBuilder>{
          //5
          '/welcomeScreen': (BuildContext context) => WelcomeScreen(), //6
          '/homeScreen': (BuildContext context) => Home("Jane Doe", "assets/images/man.png", 100)
        },
        debugShowCheckedModeBanner: false);
  }
}

/* DARK THEME: DON'T DELETE

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(
      brightness: Brightness.dark,                        // new
    ), home: WelcomeScreen(),
        routes: <String, WidgetBuilder>{ //5
          '/welcomeScreen': (BuildContext context) => WelcomeScreen(), //6
          '/homeScreen': (BuildContext context) => Home()}, debugShowCheckedModeBanner: false);
  }
}

 */
