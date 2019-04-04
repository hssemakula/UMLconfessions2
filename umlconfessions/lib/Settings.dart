import 'package:flutter/material.dart';
import 'main.dart';
import 'TermsOfService.dart';

class Settings extends StatefulWidget {
  @override
  SettingsState createState() => new SettingsState();
}

class SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: bloc.darkThemeEnabled,
        initialData: false,
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20, right: 10),
                  height: 60,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Dark mode",
                              style: TextStyle(
                                fontSize: 20
                              ),
                            ),
                            Switch(
                              value: snapshot.data,
                              onChanged: bloc.changeTheme,
                            ),
                          ])),
                ),
                Divider(),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 10),
                    height: 60,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Terms of Service",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TermsOfService()),
                    );
                  },
                ),
                Divider(),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 10),
                    height: 60,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Delete account",
                          style: TextStyle(
                              fontSize: 20,
                              //check if  dark theme, change color
                              color: Theme.of(context).brightness == Brightness.dark?  Colors.white: Colors.black54,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  onTap: () {},
                ),
                Divider(),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 10),
                    height: 60,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Log out",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          );
        });
  }
}
