import 'package:flutter/material.dart';
import 'CreateAccountFinal.dart';
import 'CurrentUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
/*This is the first page for creating an account.
* It prompts the user for a username and an email
* Front End by Hillary Ssemakula*/
final FirebaseAuth _auth = FirebaseAuth.instance;

class CreateAccountOne extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateAccountOneState();
  }
}

class CreateAccountOneState extends State<CreateAccountOne> {
  Widget build(BuildContext context) {
    dynamic res;

    return Scaffold(
        appBar: AppBar(
          title: Container(
              child: Image.asset('assets/images/logo.png'), height: 30),
          centerTitle: true,
          backgroundColor: Theme.of(context).canvasColor,
          //color of whole app
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF0072bc)),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 35, top: 10, right: 35, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            'Create your account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 29,
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 50),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: CurrentUser.usernameMain,
                                  style: TextStyle(fontSize: 20),
                                  decoration: const InputDecoration(
                                    labelStyle: TextStyle(fontSize: 17),
                                    border: OutlineInputBorder(),
                                    //gives beautiful textbox design

                                    hintText: 'Choose a user name',
                                    labelText: 'Name',
                                  ),
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
                                Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: TextFormField(
                                      controller: CurrentUser.emailMain,
                                      style: TextStyle(fontSize: 20),
                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(fontSize: 17),
                                        border: OutlineInputBorder(),
                                        //gives beautiful textbox design

                                        hintText: 'someone@example.com',
                                        labelText: 'Email',
                                      ),
                                      onSaved: (String value) {
                                        // This optional block of code can be used to run
                                        // code when the user saves the form.
                                      },
                                      validator: (String value) {
                                        return value.contains('@')
                                            ? 'Do not use the @ char.'
                                            : null;
                                      },
                                    ))
                              ],
                            )),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            RaisedButton(
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: Color(0xFF0072bc),
                              elevation: 2.0,
                              splashColor: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35)),
                              onPressed: () {

                                if(CurrentUser.usernameMain.text == "" || CurrentUser.emailMain.text == ""){
                                  Fluttertoast.showToast(
                                    msg: "You must enter both your username and your email to proceed.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                  );
                                } else {


                                  //_doSignUp();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreateAccountFinal()),
                                  );
                                }
                              },
                            )
                          ],
                        ))
                      ],
                    ),
                  )), //whole thing is wrapped in box so that when keyboard comes up it doesn't squish it
            );
          },
        ));
  }
}
