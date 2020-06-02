import 'package:flash_chat/screens/common_screen.dart';
import 'package:flash_chat/screens/fifth_screen.dart';
import 'package:flash_chat/screens/join_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JoinScreen extends StatefulWidget {
  static const String id='join_screen';
  @override
  _JoinScreenState createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final messageTextController=TextEditingController();
  final _firestore=Firestore.instance;
  String messagetext;
  final _auth=FirebaseAuth.instance;
  String id;
  String protein;
  String proteinseq;



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
                  id=value;
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
                        if(id.trim()=="1543") {
                          Navigator.pushNamed(context, CommonScreen.id);
                        }
                        //Implement send functionality.
                      },
                      child: Text(
                        'MOVE TO GAME SCREEN',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                ]
              ),

          ),

      ),
    );
  }
}
