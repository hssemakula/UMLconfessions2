import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:umlconfessions/FirebaseDatabaseUsage.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'Themer.dart';

import 'package:flutter/material.dart';
import 'package:umlconfessions/FirebaseDatabaseUsage.dart';

class AddConfessionDialog extends StatefulWidget {

  final String post_Key;
 final String email;
 final String username;
 final String userID;

  //AddConfessionDialog({Key key, this.post_Key}) : super(key: key);
  AddConfessionDialog(Key key, this.post_Key, this.email, this.username, this.userID) : super(key: key);


  @override
  AddConfessionDialogState createState() => new AddConfessionDialogState();
}

class AddConfessionDialogState extends State<AddConfessionDialog> {
  String profilePicture = 'assets/images/man.png';
  final GlobalKey<FormState> _key_for_form = new GlobalKey<FormState>();
  String val;
  bool isConfessDisabled = true;

  void _submit() {
    final FormState f = _key_for_form.currentState;

    FirebaseDatabaseUsage.createPost().then((String postKey) {
      FirebaseDatabaseUsage.pullText(postKey, val);
      FirebaseDatabaseUsage.createPostUser(postKey, widget.email, widget.username, widget.userID);
    });

    Navigator.pop(context);

    //if(!f.validate()){

    //} else {
    // f.save();
    //}
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            child: RaisedButton(
                disabledColor: Themer.setColor(context, Color(0x990072bc), Colors.white70),
                child: Text(
                  'Confess',
                  style: TextStyle(
                      color: Themer.setColor(context, Colors.white, Colors.black54),
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: isConfessDisabled ? null : _submit,
                //if user hasn't typed anything confess button stays disabled
                /*() {
                  //TODO: Handle save

                },*/
                elevation: 0,
                color: Themer.setColor(context, Color(0xFF0072bc), null),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            padding: EdgeInsets.only(top: 12, bottom: 10),
            margin: EdgeInsets.only(right: 15, top: 3),
          ),
        ],
        backgroundColor:  Theme.of(context).canvasColor,
        iconTheme: IconThemeData(color: Themer.setColor(context, Colors.black, null)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 30, right: 10, left: 10),
          child: IntrinsicWidth(
            child: Column(
              children: <Widget>[
                //profile picture and textbox row
                Row(
                  //profile picture
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 37,
                      width: 37,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(profilePicture),
                              fit: BoxFit.cover)),
                    ),

                    //container for text input for confession
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      //device width - 100
                      padding: EdgeInsets.only(left: 15),
                      margin: EdgeInsets.only(bottom: 20),
                      height: MediaQuery.of(context).size.height / 2,

                      child: TextField(
                        key: _key_for_form,
                        style: TextStyle(fontSize: 20, height: 1.2),
                        maxLines: null,
                        maxLength: 180,
                        autofocus: true,
                        decoration: const InputDecoration.collapsed(
                          hintText: "What's happening?",
                        ),
                        onChanged: (String value) {
                          val = value;
                          setState(() {
                            val == ""
                                ? isConfessDisabled = true
                                : isConfessDisabled = false;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
