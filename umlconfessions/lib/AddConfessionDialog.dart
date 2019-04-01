import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:umlconfessions/FirebaseDatabaseUsage.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:umlconfessions/FirebaseDatabaseUsage.dart';

class AddConfessionDialog extends StatefulWidget {
  final String post_Key;

  AddConfessionDialog({Key key, this.post_Key}) : super(key: key);

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
                disabledColor: Color(0x990072bc),
                child: Text(
                  'Confess',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: isConfessDisabled? null: _submit, //if user hasn't typed anything confess button stays disabled
                /*() {
                  //TODO: Handle save

                },*/
                elevation: 0,
                color: Color(0xFF0072bc),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            padding: EdgeInsets.only(top: 12, bottom: 10),
            margin: EdgeInsets.only(right: 15, top: 3),
          ),
        ],
        backgroundColor: Theme.of(context).canvasColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
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
                    //height: MediaQuery.of(context).size.height - 200, //device height - 200px
                    width: MediaQuery.of(context).size.width - 100,
                    //device width - 100
                    padding: EdgeInsets.only(left: 15),
                    margin: EdgeInsets.only(bottom: 20),
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height / 2,
                    ),
                    child: TextField(
                      key: _key_for_form,
                      style: TextStyle(fontSize: 20, height: 1.2),
                      maxLines: null,
                      autofocus: true,
                      decoration: const InputDecoration.collapsed(
                        hintText: "What's happening?",
                      ),

                      onChanged: (String value) {
                        val = value;
                        setState(() {
                          val == ""? isConfessDisabled = true: isConfessDisabled = false;
                        });
                      },
                    ),
                  )
                ],
              ),
              Divider(
                color: Color(0xFF0072bc),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                margin: EdgeInsets.only(right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        OMIcons.photo,
                        size: 30,
                        color: Color(0xFF0072bc),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
