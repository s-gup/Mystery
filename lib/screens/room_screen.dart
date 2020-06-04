import 'package:flash_chat/screens/common_screen.dart';
import 'package:flash_chat/screens/id_screen.dart';
import 'package:flash_chat/screens/join_screen.dart';
import 'package:flash_chat/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'count_perroom.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'back_end.dart';

class RoomScreen extends StatefulWidget {
  static const String id = 'room_screen';
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  static List<Room> roomList = List();
  Room room;
  DatabaseReference roomRef;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // making new room
    room = Room("1543", List(), 0);
    roomRef = FirebaseDatabase.instance.reference().child("roomList");

    //roomRef.onChildAdded.listen(_onEntryAdded);
    //roomRef.onChildChanged.listen(_onEntryChanged);
//    roomRef.push().set({
//      "roomId": 1543,
//      "userList": List(),
//      "counter": 0,
//    });
  }

  void pushNewDataToServer() {
    roomRef.push().set(room.toJson());
  }

  _onEntryAdded(Event event) {
    setState(() {
      roomList.add(Room.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = roomList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      roomList[roomList.indexOf(old)] = Room.fromSnapshot(event.snapshot);
    });
  }

  void createNewRoom() {
    room = Room('1543', List(), 0);
    roomRef.set({
      "roomId": 1543,
      "userList": List(),
      "counter": 0,
    });
    //DatabaseReference pushedRoomRef = roomRef.push();
    //String id=pushedRoomRef.key;
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
                  onPressed: () {
                    //createNewRoom();
                    roomRef.push().set({
                      "roomId": 1543,
                      "userList": List(),
                      "counter": 0,
                    });

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return IdScreen(
                        roomId: '1543',
                      );
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
                  onPressed: () {
                    Navigator.pushNamed(context, JoinScreen.id);
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
