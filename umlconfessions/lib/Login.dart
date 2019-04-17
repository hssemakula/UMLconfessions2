import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseUser fbUser;
TextEditingController _accountEmail  = new TextEditingController();
TextEditingController _accountPassword = new TextEditingController();
class LogIn extends StatelessWidget {


  Widget build(BuildContext context) {

    String username;
    String email;
  String password;
  String userID;

    void _doSignIn() async {
      password =_accountPassword.text;
      email =_accountEmail.text;
      fbUser = await _auth.signInWithEmailAndPassword(

          email: email,

          password: password

      );


          username = fbUser.displayName;



      fbUser = await _auth.currentUser();
      userID = fbUser.uid;

      Fluttertoast.showToast(
        msg: fbUser.displayName,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
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
                        left: 35, top: 10, right: 35, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(bottom: 50),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 15),
                                  constraints: BoxConstraints(minWidth: viewportConstraints.maxWidth), //add this so that container doesn't wrap text width and mess up margin
                                  child: Text(
                                    'Log in to UML Confessions.',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _accountEmail,
                                  style: TextStyle(fontSize: 20),
                                  //
                                  decoration: const InputDecoration(
                                    labelStyle: TextStyle(fontSize: 17),
                                    border: OutlineInputBorder(),
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
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: TextFormField(
                                     controller: _accountPassword,
                                      obscureText: true,
                                      style: TextStyle(fontSize: 20),
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
                                    ))
                              ],
                            )),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            RaisedButton(
                              child: const Text(
                                'Log in',
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
                                _doSignIn();
                                MaterialPageRoute rt = new MaterialPageRoute(
                                    builder: (context) =>
                                        Home(username,
                                            "assets/images/man.png",
                                            100,
                                            315,email,password,fbUser, userID));

                                Navigator.of(context)
                                    .pushNamedAndRemoveUntil('/homeScreen', (Route<dynamic> route) => false);
                                Navigator.push(
                                  context,
                                  rt,
                                );

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
