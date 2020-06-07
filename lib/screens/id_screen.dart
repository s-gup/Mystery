import 'package:flash_chat/screens/fifth_screen.dart';
import 'package:flash_chat/screens/join_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseUser loggin;

class IdScreen extends StatefulWidget {
  static const String id = 'id_screen';
  final roomId;
  final email;

  IdScreen({this.roomId, this.email});
  @override
  _IdScreenState createState() => _IdScreenState();
}

class _IdScreenState extends State<IdScreen> {
  final messageTextController = TextEditingController();
  final _firestore = Firestore.instance;
  String messagetext;
  final _auth = FirebaseAuth.instance;
  String id;
  String protein;
  String proteinseq;
  String roomId;
  String email;
  String endTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    roomId = widget.roomId;
    email = widget.email;
    //endTime = widget.endTime;
    print(roomId);
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
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: SelectableText(
                        'YOUR ROOM ID IS: $roomId',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return JoinScreen(email);
                        }));
                        //Implement send functionality.
                      },
                      child: Text(
                        'JOIN ROOM',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
