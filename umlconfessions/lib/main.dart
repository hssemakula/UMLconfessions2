import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: WelcomeScreen(),
        routes: <String, WidgetBuilder>{ //5
          '/welcomeScreen': (BuildContext context) => WelcomeScreen(), //6
          '/homeScreen': (BuildContext context) => Home()});
  }
}
