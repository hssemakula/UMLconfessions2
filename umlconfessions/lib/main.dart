import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'home.dart';
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
          '/homeScreen': (BuildContext context) => Home()
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
