import 'package:flutter/material.dart';
import 'Themer.dart';

class ReportPostDialog extends StatefulWidget {
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
                  Text("Harrasment")
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
