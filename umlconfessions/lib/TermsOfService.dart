import 'package:flutter/material.dart';
import 'Themer.dart';

/*
* This is the class for the terms of service page.  Made by Hillary Ssemakula
* Contains information that users must agree to before creating an account
* */

class TermsOfService extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'UML Confessions',
            style: TextStyle(color: Themer.setColor(context, Colors.black, null)),
          ),
          backgroundColor: Theme.of(context).canvasColor,
          //color of whole app
          elevation: 0,
          iconTheme: IconThemeData(
              color: Themer.setColor(context, Color(0xFF0072bc), null)),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: 300,
                      color: Color(0xFF0072bc),
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 45),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 35, top: 10, right: 35, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                "UML Confessions Terms of Service",
                                style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 40),
                                child: Text(
                                  "1. Agreement",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Color(0xFF0072bc),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "You have to agree to the terms and conditions before using this app.",
                                  style: TextStyle(fontSize: 17, height: 1.2),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Text(
                                  "2. Threats and Harassment",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Color(0xFF0072bc),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "Targeted Harassment will make you subject to disciplinary action. Threats of violence will result in a permanent ban. Posting personal information will make you subject to disciplinary action.",
                                  style: TextStyle(fontSize: 17, height: 1.2),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Text(
                                  "3. Spamming",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Color(0xFF0072bc),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "Spamming will make you subject to disciplinary action.",
                                  style: TextStyle(fontSize: 17, height: 1.2),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Text(
                                  "4. Legal",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Color(0xFF0072bc),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20, bottom: 30),
                                child: Text(
                                  "This app is compliant with all US laws including libel laws. This app is only for use by Umass Lowell students.",
                                  style: TextStyle(fontSize: 17, height: 1.2),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.only(
                          left: 35, top: 40, right: 35, bottom: 40),
                      child: Text(
                        "© 2019 UML confessions, Inc.\nwww.umlconfessions.com\nTerms of Service\nEnglish",
                        style: TextStyle(
                            color: Colors.white,
                            height: 1.2,
                            fontWeight: FontWeight.w100),
                      ),
                      color: Color(0xFF0072bc),
                    )
                  ],
                ),
              ), //whole thing is wrapped in box so that when keyboard comes up it doesn't squish it
            );
          },
        ));
  }
}
