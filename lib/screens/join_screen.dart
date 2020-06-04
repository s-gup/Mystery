import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/common_screen.dart';
import 'package:flash_chat/screens/fifth_screen.dart';
import 'package:flash_chat/screens/join_screen.dart';
import 'waiting_room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'count_perroom.dart';
import 'back_end.dart';
import 'package:firebase_database/firebase_database.dart';

class JoinScreen extends StatefulWidget {
  static const String id = 'join_screen';
  @override
  _JoinScreenState createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final messageTextController = TextEditingController();
  final _firestore = Firestore.instance;
  String messagetext;
  final _auth = FirebaseAuth.instance;
  String id;
  String protein;
  String proteinseq;
  //CountRoom countRoom = CountRoom();

  static List<Room> roomList = List();
  Room room;
  DatabaseReference roomRef;
  Room toUpdateRoom;

  @override
  void initState() async {
    // TODO: implement initState
    super.initState();
    String user = _auth.currentUser().toString();

    roomRef = FirebaseDatabase.instance.reference().child('roomList');
    //roomRef.onChildAdded.listen(_onEntryAdded);
    roomRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryChanged(Event event) {
    var old = roomList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      roomList[roomList.indexOf(old)] = Room.fromSnapshot(event.snapshot);
    });
  }

  findUpdateRoom(String id) {
    toUpdateRoom = roomList.singleWhere((entry) {
      return entry.roomId == id;
    });
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
                  onPressed: () {
                    if (id.trim() == "1543") {
//                      countRoom.incrementCount();
//                      print(countRoom.getCount());

                      Navigator.pushNamed(context, WaitScreen.id);
                    }
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
