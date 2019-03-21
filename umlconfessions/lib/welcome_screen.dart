import 'package:flutter/material.dart';
import 'create_account_one.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Container(child: Image.asset('assets/images/logo.png'), height: 30),
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF0072bc)),
      ),
      body: Padding(
          padding: EdgeInsets.only(left: 35, top: 10, right: 35, bottom: 15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //empty container works with Mai xis alignment to push create account button to middle of screen.
                Container(),
                Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Ptssss...\nI won\'t tell, if you won\'t.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 29),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Container(
                              child: RaisedButton(
                                child: const Text(
                                  'Create account',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                padding: EdgeInsets.all(15),
                                color: Color(0xFF0072bc),
                                elevation: 2.0,
                                splashColor: Colors.blueGrey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreateAccountOne()),
                                  );
                                },
                              ),
                            )),
                      ],
                    )),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Have an account already?',
                        style: TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.only(bottom: 8, right: 10),
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 17,
                          color: Color(0xFF0072bc),
                        ),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ])),
    );
  }
}
