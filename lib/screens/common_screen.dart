import 'package:flash_chat/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'hint_screen.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'timer.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'chat_screen.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'result_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'user.dart';
import 'dart:async';
import 'dart:convert';
import 'package:screen/screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/common_screen.dart';
import 'package:flash_chat/screens/fifth_screen.dart';
import 'package:flash_chat/screens/join_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'waiting_room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'count_perroom.dart';
import 'back_end.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/waiting_room.dart';
import 'user.dart';
import 'package:flash_chat/screens/waiting_room.dart';

class CommonScreen extends StatefulWidget {
  static const String id = 'common_screen';
  final idd;
  final userList;
  CommonScreen({this.idd, this.userList});

  @override
  _CommonScreenState createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> {
  String id;
  DatabaseReference roomRef3;
  List<User> userObjs;
  bool _isKeptOn = false;
  double _brightness = 1.0;
  @override
  void initState() {
    super.initState();
    Screen.keepOn(true);
    id = widget.idd;
    userObjs = widget.userList;
  }
  initPlatformState() async {
    bool keptOn = await Screen.isKeptOn;
    double brightness = await Screen.brightness;
    setState((){
      _isKeptOn = keptOn;
      _brightness = brightness;
    });
  }
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.pushNamed(context, LoginScreen.id),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(actions: <Widget>[
          IconButton(
              icon: Icon(Icons.message),
              onPressed: () {
                Navigator.pushNamed(context, ChatScreen.id);
                //Implement logout functionality
              }),
        ]),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    minWidth: 200.0,
                    height: 42.0,
                    child: FlatButton(
                      color: Colors.green,
                      child: Countdown(
                        seconds: 10,
                        build: (_, timer) => Text(timer.toString()),
                        interval: Duration(
                          milliseconds: 100,
                        ),
                        onFinished: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ChatScreen(
                              idd: id,
                            );
                          }));
                          print('50 s completete codkcedkior!');
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, LoginScreen.id);
                      //Go to login screen.
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HintScreen(
                          hintKey: 1,
                          hintType: true,
                        );
                      }));
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      userObjs[0].email,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, SecondScreen.id);
                      //Go to login screen.
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HintScreen(
                          hintKey: 2,
                          hintType: true,
                        );
                      }));
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      userObjs[1].email,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, RegistrationScreen.id);
                      //Go to registration screen.
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HintScreen(
                          hintKey: 3,
                          hintType: true,
                        );
                      }));
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      userObjs[2].email,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, RegistrationScreen.id);
                      //Go to registration screen.
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HintScreen(
                          hintKey: 4,
                          hintType: true,
                        );
                      }));
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      userObjs[3].email,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, RegistrationScreen.id);
                      //Go to registration screen.
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HintScreen(
                          hintKey: 5,
                          hintType: false,
                        );
                      }));
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      userObjs[4].email,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
