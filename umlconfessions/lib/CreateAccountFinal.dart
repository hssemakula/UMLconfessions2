import 'package:flutter/material.dart';
import 'TermsOfService.dart';
import 'Home.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class CreateAccountFinal extends StatelessWidget {






  Widget build(BuildContext context) {
    TextEditingController _accountName = new TextEditingController();

    TextEditingController _accountPassword = new TextEditingController();

    void _handleSignUp() async {

      FirebaseUser fbUser = await _auth.createUserWithEmailAndPassword(

          email: _accountName.text,

          password: _accountPassword.text

      );

    }

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
                        left: 35, top: 10, right: 35, bottom: 50),
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
                                 // controller: _accountPassword,
                                  style: TextStyle(fontSize: 20),
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelStyle: TextStyle(fontSize: 17),
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
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
                                      obscureText: true,
                                      style: TextStyle(fontSize: 20),
                                      decoration: const InputDecoration(
                                        labelStyle: TextStyle(fontSize: 17),
                                        border: OutlineInputBorder(),
                                        labelText: 'Re-enter Password',
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
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Wrap(
                              spacing: 4,
                              runSpacing: 7,
                                children: <Widget>[
                              Text(
                                'By signing up, you agree to our',
                                softWrap: true,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              InkWell(
                                //use this to make colored text that can open another page.
                                child: Text(
                                  "Terms of Service",
                                  style: TextStyle(color: Color(0xFF0072bc)),
                                ),
                                onTap: () {
                                  //acts as on pressed but because it's not a button.
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TermsOfService()),
                                  );
                                },
                              )
                            ]),
                            //wrap acts like a row but wraps if there is no space on screen

                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: RaisedButton(
                                child: const Text(
                                  'Sign up',
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
                                  //AFTER SUCCESSFUL SIGNUP, remove all widgets and load home screen
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil('/homeScreen', (Route<dynamic> route) => false);
                                },
                              ),
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
