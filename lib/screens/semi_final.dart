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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'result_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:progress_dialog/progress_dialog.dart';
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

class SemiFinal extends StatefulWidget {
  final id;
  final leader;
  final currentUser;
  SemiFinal({this.id, this.leader, this.currentUser});
  @override
  _SemiFinalState createState() => _SemiFinalState();
}

class _SemiFinalState extends State<SemiFinal> {
  final messageTextController = TextEditingController();
  final _firestore = Firestore.instance;
  String messagetext;
  final _auth = FirebaseAuth.instance;
  DatabaseReference roomRef;
  String idd;
  String leader;
  String currentMail;
  bool gotMessage = false;
  ProgressDialog pr;
  String answer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idd = widget.id;
    pr = ProgressDialog(context);
    leader = widget.leader;
    currentMail = widget.currentUser;
  }

  showingProgress() async {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);

    pr.style(
        message: 'waiting...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    await pr.show();
  }

  Future getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggin = user;
        print(loggin.email);
        currentMail = loggin.email;
      }
    } catch (e) {
      print(e);
    }
  }

  Future getLeader() async {
    roomRef = FirebaseDatabase.instance
        .reference()
        .child('roomList')
        .child(idd)
        .child('leader');
    var value;
    await roomRef.once().then((DataSnapshot dataSnapshot) {
      value = dataSnapshot.value;

      leader = value.toString();
    });
  }

  createAlertDialog(BuildContext context) async {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Your Answer ?"),
            content: TextField(
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Submit'),
                onPressed: () async {
                  answer = customController.text.toString();
                  setState(() {
                    gotMessage = true;
                  });

                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return ResultScreen(
                      userAnswer: answer,
                    );
                  }));
                },
              ),
            ],
          );
        });
  }

  Widget getButton() {
    if (currentMail == leader) {
      print('enter');
      return createAlertDialog(context);
    } else {
      if (gotMessage == false) {
        return showingProgress();
      } else {
        print('entered');
        pr.hide();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ResultScreen(
            userAnswer: answer,
          );
        }));
        return FlatButton();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: getButton());
  }
}
