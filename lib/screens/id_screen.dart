import 'package:auto_size_text/auto_size_text.dart';
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
        appBar: AppBar(
          title: Text('ROOM ID'),
        ),
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/idd.jpg'),
              fit: BoxFit.contain,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Center(child: Text(roomId)),
//                    onLongPress: () {
//                      Clipboard.setData(new ClipboardData(text: roomId));
//                      key.currentState.showSnackBar(new SnackBar(
//                        content: new Text("Copied to Clipboard"),
//                      ));
//                    },
                SizedBox(
                  height: 412,
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: AutoSizeText(
                          'YOUR ROOM ID : ',
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                            //fontStyle: FontStyle.italic,
                            fontFamily: 'Spartan MB',
                          ),
                        ),
                      ),
                      Builder(
                        builder: (context) => Flexible(
                          child: RaisedButton.icon(
                            icon: Icon(Icons.content_copy),
                            onPressed: () {
                              Clipboard.setData(new ClipboardData(text: roomId));
                              Scaffold.of(context).showSnackBar(new SnackBar(
                                content: Text(
                                  "Copied to Clipboard",
                                  style: kMessageTextStyle,
                                ),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.blueAccent,
                              ));
                            },
                            label: Flexible(child: Text(roomId)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
//            Builder(
//              builder: (context) => RaisedButton.icon(
//                icon: Icon(Icons.content_copy),
//                onPressed: () {
//                  Clipboard.setData(new ClipboardData(text: roomId));
//                  Scaffold.of(context).showSnackBar(new SnackBar(
//                    content: Text(
//                      "Copied to Clipboard",
//                      style: kMessageTextStyle,
//                    ),
//                    duration: Duration(seconds: 2),
//                    backgroundColor: Colors.black26,
//                  ));
//                },
//                label: Text(roomId),
//              ),
//            ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: RaisedButton(
                    splashColor: Colors.pink,
                    elevation: 5,
                    color: Colors.transparent,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
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
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
//            Container(
//              decoration: kMessageContainerDecoration,
//              child: Row(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Expanded(
//                    child: SelectableText(
//                      'YOUR ROOM ID IS: $roomId',
//                      style: TextStyle(
//                        color: Colors.white,
//                      ),
//                    ),
//                  ),
//                  FlatButton(
//                    onPressed: () {
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (context) {
//                        return JoinScreen(email);
//                      }));
//                      //Implement send functionality.
//                    },
//                    child: Text(
//                      'JOIN ROOM',
//                      style: TextStyle(
//                        color: Colors.white,
//                        fontWeight: FontWeight.bold,
//                        fontSize: 18.0,
//                      ),
//                    ),
//                  )
//                ],
//              ),
//            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
