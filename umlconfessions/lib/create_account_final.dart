import 'package:flutter/material.dart';
import 'terms_of_service.dart';

class CreateAccountFinal extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Container(child: Image.asset('assets/images/logo.png'), height: 30),
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
              child:
              Padding(
                padding: EdgeInsets.only(left: 35, top: 10, right: 35, bottom: 50),
                child:  Column(
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
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(fontSize: 17),
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
                                  style: TextStyle(fontSize: 15),
                                  decoration: const InputDecoration(
                                    labelStyle: TextStyle(fontSize: 17),
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
                            Row(children: <Widget>[
                              Text('By signing up, you agree to our', style: TextStyle(color: Colors.grey[600]),),
                              FlatButton(
                                padding: EdgeInsets.only(top: 0, left: 5, right: 0, bottom: 0),
                                child: Text("Terms of Service", style: TextStyle(color: Color(0xFF0072bc)),),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TermsOfService()),
                                  );
                                },
                              )
                            ]),
                            RaisedButton(
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
                              onPressed: () {},
                            )
                          ],
                        ))
                  ],
                ),
              )








            ),  //whole thing is wrapped in box so that when keyboard comes up it doesn't squish it
          );
        },
      )
















    );
  }
}

/*

Padding(
          padding: EdgeInsets.only(left: 35, top: 10, right: 35, bottom: 50),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
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
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(fontSize: 17),
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
                            style: TextStyle(fontSize: 15),
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(fontSize: 17),
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
                  Row(children: <Widget>[
                    Text('By signing up, you agree to our', style: TextStyle(color: Colors.grey[600]),),
                    FlatButton(
                      padding: EdgeInsets.only(top: 0, left: 5, right: 0, bottom: 0),
                      child: Text("Terms of Service", style: TextStyle(color: Color(0xFF0072bc)),),
                      onPressed: () {},
                    )
                  ]),
                  RaisedButton(
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
                    onPressed: () {},
                  )
                ],
              ))
            ],
          ),
        )
 */
