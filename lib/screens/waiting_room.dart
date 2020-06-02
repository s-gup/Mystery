import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'count_perroom.dart';
import 'common_screen.dart';
import 'package:timer_count_down/timer_count_down.dart';

class WaitScreen extends StatefulWidget {
  static const String id = 'waiting_room';
  @override
  _WaitScreenState createState() => _WaitScreenState();
}

class _WaitScreenState extends State<WaitScreen> {
  CountRoom countRoom = CountRoom();

  Widget textToDisplay() {
    setState(() {
      countRoom.getCount();
    });
    if (countRoom.getCount() == 5) {
      return FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, CommonScreen.id);

          //Implement send functionality.
        },
        child: Text(
          'TIME STARTED ! MOVE TO GAME SCREEN',
          style: kSendButtonTextStyle,
        ),
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
        body: Column(
          children: <Widget>[
            textToDisplay(),
            Center(
              child: Countdown(
                seconds: 20,
                build: (_, double time) => Text(time.toString()),
                interval: Duration(
                  milliseconds: 100,
                ),
                onFinished: () {
                  print('Timer is done!');
                },
              ),
            ),
          ],
        ));
  }
}
