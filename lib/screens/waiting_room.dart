import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'count_perroom.dart';
import 'common_screen.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'timer.dart';
import 'package:firebase_database/firebase_database.dart';

class WaitScreen extends StatefulWidget {
  static const String id = 'waiting_room';
  @override
  _WaitScreenState createState() => _WaitScreenState();
}

class _WaitScreenState extends State<WaitScreen> {
  CountRoom countRoom = CountRoom();
  //final CountdownController controller = CountdownController();
  var timer = DateTime.now();

  Widget textToDisplay() {
    setState(() {
      countRoom.getCount();
    });
    if (countRoom.getCount() >= 5) {
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
    } else {
      return FlatButton(
        child: Text(
          'WAITING FOR OTHER MEMBERS TO JOIN',
          style: kSendButtonTextStyle,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MYSTERY GAME !!'),
        ),
        body: textToDisplay());
  }
}
