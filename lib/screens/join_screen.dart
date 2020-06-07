import 'dart:async';
import 'dart:convert';

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

class JoinScreen extends StatefulWidget {
  static const String id = 'join_screen';
  final email;

  JoinScreen(this.email);
  @override
  _JoinScreenState createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final messageTextController = TextEditingController();
  final _firestore = Firestore.instance;
  String messagetext;
  final _auth = FirebaseAuth.instance;
  String id;
  bool idFound = false;
  String idd;
  static List<int> roomList = List();
  String email;

  DatabaseReference roomRef;
  DatabaseReference roomRef2;
  DatabaseReference roomRef3;

  int oldCount;
  int newCount;
  String endTime;
  String changed;
  User user;
  List<User> userObjs;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    var value;
    //setTime();
    email = widget.email.toString();
  }

  Future getEndDate() async {
    idd = id.trim();
    roomRef2 = FirebaseDatabase.instance
        .reference()
        .child('roomList')
        .child(id)
        .child('endTime');
    var value;
    await roomRef2.once().then((DataSnapshot dataSnapshot) {
      value = dataSnapshot.value;

      endTime = value.toString();
      //endTime = DateTime.parse(time);
      //print(endTime);
    });
  }

  Future findOldCount() async {
    var value;
    var key;

    idd = id.trim();
    roomRef = FirebaseDatabase.instance
        .reference()
        .child('roomList')
        .child(idd)
        .child('count');
    await roomRef.once().then((DataSnapshot dataSnapshot) {
      key = dataSnapshot.key;
      value = dataSnapshot.value;
      if (value == null) {
        //Navigator.pop(context);
        Navigator.pushNamed(context, LoginScreen.id);
      }

      String strCount = value.toString();
      //print(strCount);
      oldCount = int.parse(strCount);
      //print(oldCount);
    });
    print('countviewed$oldCount');
//    roomRef2 = FirebaseDatabase.instance
//        .reference()
//        .child('roomList')
//        .child(id)
//        .child('endTime');
//    await roomRef2.once().then((DataSnapshot dataSnapshot) {
//      var value1 = dataSnapshot.value;
//
//      endTime = value1.toString();
//      print(endTime);
//      //endTime = DateTime.parse(time);
//      //print(endTime);
//    });
  }

  Future updateCount() async {
    newCount = oldCount + 1;
    //String idd = id.trim();
    roomRef =
        FirebaseDatabase.instance.reference().child('roomList').child(idd);
    await roomRef.update(
      {'count': newCount},
    );
    print('countupdated$newCount');
  }

  Future updateList() async {
    var value;

    user = User(email, "1");

    roomRef3 = FirebaseDatabase.instance
        .reference()
        .child('roomList')
        .child(idd)
        .child('list');
    await roomRef3.once().then((DataSnapshot dataSnapshot) {
      value = dataSnapshot.value;
      var userObjsJson = jsonDecode(value) as List;
      userObjs = userObjsJson.map((tagJson) => User.fromJson(tagJson)).toList();
      userObjs.add(user);

      //String stremail = email.toString();
//      String stremail = "$email";
//      print(stremail);
//      a.add(stremail);
//      changed = a.toString();
    });
    print('listget$user');
  }

  Future addToList() async {
    String changed = jsonEncode(userObjs);
    roomRef =
        FirebaseDatabase.instance.reference().child('roomList').child(idd);
    await roomRef.update(
      {'list': changed},
    );
    print('listupdated$changed');
  }

  void setTime() {
    var today = new DateTime.now();
    String startTime = today.toString();
    print(today);
    var twoMinutesFromNow = today.add(new Duration(minutes: 2));
    print(twoMinutesFromNow);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.pinkAccent,
        child: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    //Do something with the user input.
                    id = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your ROOM ID',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () async {
//                      countRoom.incrementCount();
//                      print(countRoom.getCount());

                    Future a = await findOldCount();
                    Future b = await updateCount();
                    Future c = await updateList();
                    Future d = await addToList();
                    Future e = await getEndDate();
                    print('endtime $endTime');
                    //getEndDate();
                    //Navigator.pushNamed(context, WaitScreen.id);
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return WaitScreen(
                        idd: idd,
                        endDay: endTime,
                      );
                    }));

                    //Implement send functionality.
                  },
                  child: Text(
                    'MOVE TO WAIT ROOM',
                    style: kSendButtonTextStyle,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
