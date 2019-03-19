import 'package:flutter/material.dart';
import 'welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: WelcomeScreen(),
    );
  }
}

/* Color choices for home page
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            Text('UML confessions', style: TextStyle(color: Color(0xFF0072bc))),
      ),
    ));
  }
}
*/