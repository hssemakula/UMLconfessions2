import 'package:flutter/material.dart';

class AddConfessionDialog extends StatefulWidget {
  @override
  AddConfessionDialogState createState() => new AddConfessionDialogState();
}

class AddConfessionDialogState extends State<AddConfessionDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            child: RaisedButton(
                child: Text(
                  'Confess',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  //TODO: Handle save
                },
                elevation: 0,
                color: Color(0xFF0072bc),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            padding: EdgeInsets.only(top: 10, bottom: 10),
            margin: EdgeInsets.only(right: 20),
          ),
        ],
        backgroundColor: Theme.of(context).canvasColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Center(child: Text("CONFESS")),
    );
  }
}
