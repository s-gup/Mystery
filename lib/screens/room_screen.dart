import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
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
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'choice_screen.dart';
import 'theme_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/services.dart';
import 'package:flash_chat/constants.dart';
import 'room_screen.dart';

class RoomScreen extends StatefulWidget {
  static const String id = 'room_screen';
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  //static List<Room> roomList = List();
  String email;
  DatabaseReference roomRef;
  final _auth = FirebaseAuth.instance;
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
      'theme': '',
      'total': '0',
      'set': '1',
      'actualAns': '',
      'hints': jsonList,
      'common': '',
      'explanation': '',
    });

    roomId = pushedRoomRef.key;
    return roomId;
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
                onTap: () => SystemNavigator.pop(),
                //Navigator.pushNamed(context, LoginScreen.id),
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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/room1.png'),
              fit: BoxFit.contain,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                Container(
                  alignment: Alignment(0.5, 0),
                  width: 100.0,
                  height: 40,
                  child: Material(
                    elevation: 5.0,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      splashColor: Colors.red,
                      onPressed: () async {
                        Future b = await getCurrentUser();
                        String id = await createNewRoom();

//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (context) {
//                        return IdScreen(roomId: id, email: email);
//                      }));
                        //Go to login screen.
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ThemeScreen(
                            id: id,
                            email: email,
                          );
                        }));
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'CREATE ROOM',
                        style: TextStyle(
                          fontFamily: 'Spartan MB',
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment(0.5, 0),
                  width: 100.0,
                  height: 40,
                  child: Material(
                    elevation: 5.0,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      splashColor: Colors.red,
                      onPressed: () async {
                        Future a = await getCurrentUser();
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
                        style: TextStyle(
                          fontFamily: 'Spartan MB',
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
