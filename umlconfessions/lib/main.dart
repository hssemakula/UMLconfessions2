import 'package:flutter/material.dart';
import 'WecomeScreen.dart';
import 'Home.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                //5
                '/welcomeScreen': (BuildContext context) => WelcomeScreen(), //6
                '/homeScreen': (BuildContext context) => Home(
                    "John Doe",
                    "assets/images/man.png",
                    100,
                    315,
                    "someone@example.com",
                    "apassword")
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
