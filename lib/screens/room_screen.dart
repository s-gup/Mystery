import 'dart:convert';

import 'package:flash_chat/screens/common_screen.dart';
import 'package:flash_chat/screens/id_screen.dart';
import 'package:flash_chat/screens/join_screen.dart';
import 'package:flash_chat/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'count_perroom.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'back_end.dart';
import 'join_screen.dart';

class RoomScreen extends StatefulWidget {
  static const String id = 'room_screen';
  final email;
  RoomScreen(this.email);
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  //static List<Room> roomList = List();
  String email;
  DatabaseReference roomRef;
  String roomId;
  String startTime;
  String endTime;
  List<String> toAdd = List();
  var today;
  var twoMinutesFromNow;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // making new room
    email = widget.email;

    roomRef = FirebaseDatabase.instance.reference().child("roomList");

    //roomRef.onChildAdded.listen(_onEntryAdded);
    //roomRef.onChildChanged.listen(_onEntryChanged);
//    roomRef.push().set({
//      "roomId": 1543,
//      "userList": List(),
//      "counter": 0,
//    });
  }

//  _onEntryAdded(Event event) {
//    setState(() {
//      roomList.add(Room.fromSnapshot(event.snapshot));
//    });
//  }

//  _onEntryChanged(Event event) {
//    var old = roomList.singleWhere((entry) {
//      return entry.key == event.snapshot.key;
//    });
//    setState(() {
//      roomList[roomList.indexOf(old)] = Room.fromSnapshot(event.snapshot);
//    });
//  }
  void setTime() {
    today = new DateTime.now();
    startTime = today.toString();
    print(today);
    twoMinutesFromNow = today.add(new Duration(minutes: 3));
    endTime = twoMinutesFromNow.toString();
    print(twoMinutesFromNow);
  }

  Future createNewRoom() async {
    //room = new Room(1);
    setTime();
    DatabaseReference pushedRoomRef = roomRef.push();
    String jsonList = jsonEncode(toAdd);
    await pushedRoomRef.set({
//      "roomId": 1543,
//      "userList": List(),
      'count': 0,
      'currentTime': today.toString(),
      'endTime': twoMinutesFromNow.toString(),
      'list': jsonList,
      'leader': email.toString(),
      'answer': '',
    });

    roomId = pushedRoomRef.key;
    return roomId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  onPressed: () async {
                    String id = await createNewRoom();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return IdScreen(roomId: id, email: email);
                    }));
                    //Go to login screen.
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'CREATE ROOM',
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
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return JoinScreen(email);
                    }));
                    //Go to login screen.
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'JOIN ROOM',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
