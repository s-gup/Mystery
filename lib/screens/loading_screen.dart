import 'package:flash_chat/screens/first_screen.dart';
import 'package:flash_chat/screens/join_screen.dart';
import 'package:flash_chat/screens/myclass.dart';
import 'package:flash_chat/screens/room_screen.dart';
import 'package:flash_chat/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/login_screen.dart';
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
import 'waiting_room.dart';
import 'chat_screen.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'loading_screen';
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Text(
            'TIME STARTED ! SOON MOVING TO GAME SCREEN !',
            style: kSendButtonTextStyle,
          ),
        ),
        Center(
          child: Countdown(
            seconds: 10,
            build: (_, timer) => Text(timer.toString()),
            interval: Duration(
              milliseconds: 100,
            ),
            onFinished: () {
              print('Timer is done!');
              Navigator.pushNamed(context, CommonScreen.id);
            },
          ),
        ),
      ],
    );
  }
}
