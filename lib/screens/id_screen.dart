import 'package:flash_chat/screens/fifth_screen.dart';
import 'package:flash_chat/screens/join_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flash_chat/constants.dart';

import '../constants.dart';
import '../constants.dart';

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
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
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
      appBar: AppBar(
        title: Text('ROOM ID'),
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.blueAccent,
      body: Container(
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: AssetImage('images/detect7.jpg'),
//            fit: BoxFit.cover,
//          ),
//        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Center(child: Text(roomId)),
//                    onLongPress: () {
//                      Clipboard.setData(new ClipboardData(text: roomId));
//                      key.currentState.showSnackBar(new SnackBar(
//                        content: new Text("Copied to Clipboard"),
//                      ));
//                    },
            SizedBox(
              height: 3,
            ),
            Builder(
              builder: (context) => RaisedButton.icon(
                icon: Icon(Icons.content_copy),
                onPressed: () {
                  Clipboard.setData(new ClipboardData(text: roomId));
                  Scaffold.of(context).showSnackBar(new SnackBar(
                    content: Text(
                      "Copied to Clipboard",
                      style: kMessageTextStyle,
                    ),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.black26,
                  ));
                },
                label: Text(roomId),
              ),
            ),
            SizedBox(height: 5),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SelectableText(
                      'YOUR ROOM ID IS: $roomId',
                      style: TextStyle(
                        color: Colors.white,
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
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
