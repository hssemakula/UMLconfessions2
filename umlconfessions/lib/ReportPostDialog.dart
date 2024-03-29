import 'package:flutter/material.dart';
import 'Themer.dart';
import 'package:firebase_database/firebase_database.dart';

/*This is the class for the reporting posts dialog.  Made by Hillary Ssemakula*/

class ReportPostDialog extends StatefulWidget {
String confessionKey;

  ReportPostDialog(this.confessionKey);

  @override
  ReportPostDialogState createState() => new ReportPostDialogState();
}

class ReportPostDialogState extends State<ReportPostDialog> {
  bool harassmentFlag = false;
  bool spamFlag = false;
  bool threatFlag = false;

  @override
  Widget build(BuildContext context) {
    Color themeColor = Themer.setColor(context, Colors.black54, Colors.white70);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(
            Icons.feedback,
            size: 50,
          ),
          Text(
            "Your feedback helps us improve your user experience",
            style: TextStyle(fontWeight: FontWeight.w300, height: 1.2),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                Row(children: [
                  Checkbox(
                      activeColor: themeColor,
                      value: harassmentFlag,
                      onChanged: (value) {
                        setState(() {
                          harassmentFlag
                              ? harassmentFlag = false
                              : harassmentFlag = true;
                        });
                      }),
                  Text("Harassment")
                ]),
                Row(children: [
                  Checkbox(
                      activeColor: themeColor,
                      value: spamFlag,
                      onChanged: (value) {
                        setState(() {
                          spamFlag ? spamFlag = false : spamFlag = true;
                        });
                      }),
                  Text("Spam")
                ]),
                Row(children: [
                  Checkbox(
                      activeColor: themeColor,
                      value: threatFlag,
                      onChanged: (value) {
                        setState(() {
                          threatFlag ? threatFlag = false : threatFlag = true;
                        });
                      }),
                  Text("Threat")
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
