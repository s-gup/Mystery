import 'dart:developer';
import 'hint_screen.dart';
import 'package:flash_chat/screens/loading_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'count_perroom.dart';
import 'common_screen.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'timer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:timer_builder/timer_builder.dart';
import 'package:flutter/material.dart';
import 'room_screen.dart';
import 'loading_screen.dart';
import 'package:flutter_timer/flutter_timer.dart';
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

class WaitScreen extends StatefulWidget {
  static const String id = 'waiting_room';
  final idd;
  final endDay;
  WaitScreen({this.idd, this.endDay});
  @override
  _WaitScreenState createState() => _WaitScreenState();
}

class _WaitScreenState extends State<WaitScreen> {
  Duration duration = Duration(
    minutes: 2,
  );
  int count;
  String id;
  DatabaseReference roomRef1;
  DatabaseReference roomRef2;
  DatabaseReference roomRef3;
  DatabaseReference roomRef4;
  DateTime currentTime;
  DateTime timer;
  DateTime endTime;
  DateTime endTimeplus;
  DateTime endTimesubstract;
  bool timerRunning;
  int sec;
  DatabaseReference roomRef;
  List<User> userObjs;
  String email;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();

    var end = widget.endDay;
    String end1 = end.toString();
    print(end1);
    endTime = DateTime.parse(end);

    print(endTime);
    //getEndDate();
    id = widget.idd;
    roomRef2 = FirebaseDatabase.instance
        .reference()
        .child('roomList')
        .child(id)
        .child('endTime');
    roomRef1 = FirebaseDatabase.instance
        .reference()
        .child('roomList')
        .child(id)
        .child('currentTime');
    roomRef4 = FirebaseDatabase.instance
        .reference()
        .child('roomList')
        .child(id)
        .child('count');
    roomRef3 =
        FirebaseDatabase.instance.reference().child('roomList').child(id);
    int val = endTime.compareTo(getCurrentTime());
    if (val < 0) {
      Navigator.pushNamed(context, LoginScreen.id);
    }
    Duration duration = endTime.difference(getCurrentTime());
    sec = duration.inSeconds;
  }

  DateTime getCurrentTime() {
    return DateTime.now();
  }

  Future getCount() async {
    var value;
    await roomRef4.once().then((DataSnapshot dataSnapshot) {
      value = dataSnapshot.value;

      String counts = value.toString();
      count = int.parse(counts);
    });
  }

  Future getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggin = user;
        print(loggin.email);
        email = loggin.email;
      }
    } catch (e) {
      print(e);
    }
  }

  Future getList() async {
    var value;
    roomRef = FirebaseDatabase.instance
        .reference()
        .child('roomList')
        .child(id)
        .child('list');
    await roomRef.once().then((DataSnapshot dataSnapshot) {
      value = dataSnapshot.value;
      var userObjsJson = jsonDecode(value) as List;
      userObjs = userObjsJson.map((tagJson) => User.fromJson(tagJson)).toList();
    });
  }

  bool getHintType(index) {
    if (index == 5) {
      return true;
    }
    return false;
  }

  Widget finalUpdate() {
    int val = endTime.compareTo(getCurrentTime());
    if (val > 0) {
      Duration duration = endTime.difference(getCurrentTime());
      int sec = duration.inSeconds;
      return Center(
        child: Countdown(
          seconds: sec,
          build: (_, timer) => Text(timer.toString()),
          interval: Duration(
            milliseconds: 100,
          ),
          onFinished: () async {
            print('Timer is done!');
            Future a = await getCount();
            if (count >= 5) {
              Navigator.pushNamed(context, CommonScreen.id);
            } else {
              Navigator.pushNamed(context, LoginScreen.id);
            }
          },
        ),
      );
    } else {
      Navigator.pushNamed(context, LoginScreen.id);
      return FlatButton();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MYSTERY GAME !!'),
      ),
      body: Countdown(
        seconds: sec,
        build: (_, timer) => Text(timer.toString()),
        interval: Duration(
          milliseconds: 100,
        ),
        onFinished: () async {
          print('Timer is done!');
          Future a = await getCount();

          if (count >= 5) {
            Future a = await getList();
            Future b = await getCurrentUser();
            int index;
            for (int i = 0; i < 5; i++) {
              if (userObjs[i].email.trim() == email.trim()) {
                index = i;
                break;
              }
            }
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HintScreen(
                hintKey: index + 1,
                hintType: getHintType(index + 1),
                idd: id,
              );
            }));
//            Navigator.push(context, MaterialPageRoute(builder: (context) {
//              return CommonScreen(
//                userList: userObjs,
//                idd: id,
//              );
//            }));
          } else {
            Navigator.pushNamed(context, LoginScreen.id);
          }
        },
      ),
    );
  }
}
