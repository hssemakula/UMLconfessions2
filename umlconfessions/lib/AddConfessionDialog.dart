import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class AddConfessionDialog extends StatefulWidget {
  @override
  AddConfessionDialogState createState() => new AddConfessionDialogState();
}

class AddConfessionDialogState extends State<AddConfessionDialog> {
  String profilePicture = 'assets/images/man.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            child: RaisedButton(
                child: Text(
                  'Confess',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  //TODO: Handle save
                },
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
        padding: EdgeInsets.only(top:30, right: 10, left: 10),
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
                   width: MediaQuery.of(context).size.width - 100, //device width - 100
                   padding: EdgeInsets.only(left: 15),
                   margin: EdgeInsets.only(bottom: 20),
                   constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height/2,),
                   child: TextFormField(
                      style: TextStyle(fontSize: 20, height: 1.2),
                      maxLines: null,
                      autofocus: true,
                      decoration: const InputDecoration.collapsed(hintText: "What's happening?", ),

                      onSaved: (String value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      validator: (String value) {
                        return value.contains('@')
                            ? 'Do not use the @ char.'
                            : null;
                      },
                    ),
                 )
                ],
              ),
              Divider(),
              Container(
                width: MediaQuery.of(context).size.width - 20 ,
                margin: EdgeInsets.only(right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(icon: Icon(OMIcons.photo, size: 30,), onPressed: (){},)
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
