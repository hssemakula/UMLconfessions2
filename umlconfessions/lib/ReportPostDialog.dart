import 'package:flutter/material.dart';

class ReportPostDialog extends StatefulWidget {
  @override
  ReportPostDialogState createState() => new ReportPostDialogState();
}

class ReportPostDialogState extends State<ReportPostDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.feedback),
            Text("Your feedback helps us to improve your user experience")
          ],
        ),
        Column(
          children: <Widget>[
            Checkbox(value: false, onChanged: (value) {}),
            Checkbox(value: false, onChanged: (value) {}),
            Checkbox(value: false, onChanged: (value) {})
          ],
        ),
        FlatButton(
          onPressed: () {},
          child: Text("SEND"),
        )
      ],
    );
  }
}
