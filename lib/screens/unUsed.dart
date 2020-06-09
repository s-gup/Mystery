import 'dart:developer';

import 'package:flash_chat/screens/loading_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/foundation.dart';
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
import 'loading_screen.dart';
import 'package:flutter_timer/flutter_timer.dart';

class WaittScreen extends StatefulWidget {
  static const String id = 'waiting_room';
  //final count;
  final idd;
  final endDay;
  WaittScreen({this.idd, this.endDay});
  @override
  _WaittScreenState createState() => _WaittScreenState();
}

class _WaittScreenState extends State<WaittScreen> {
  //int count=widget.count;
  //CountRoom countRoom = CountRoom();
  //final CountdownController controller = CountdownController();
  //var timer = DateTime.now();
  Duration duration = Duration(
    minutes: 2,
  );
  int count;
  String id;
  DatabaseReference roomRef1;
  DatabaseReference roomRef2;
  DatabaseReference roomRef3;
  DatabaseReference roomRef4;
  DateTime currentTime;
  DateTime timer;
  DateTime endTime;
  DateTime endTimeplus;
  DateTime endTimesubstract;
  bool timerRunning;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var end = widget.endDay;
    String end1 = end.toString();
    print(end1);
    endTime = DateTime.parse(end);

    print(endTime);
    //getEndDate();
    id = widget.idd;
    roomRef2 = FirebaseDatabase.instance
        .reference()
        .child('roomList')
        .child(id)
        .child('endTime');
    roomRef1 = FirebaseDatabase.instance
        .reference()
        .child('roomList')
        .child(id)
        .child('currentTime');
    roomRef4 = FirebaseDatabase.instance
        .reference()
        .child('roomList')
        .child(id)
        .child('count');
    roomRef3 =
        FirebaseDatabase.instance.reference().child('roomList').child(id);
//    endTimeplus = endTime.add(new Duration(milliseconds: 500));
//    endTimesubstract = endTime.subtract(new Duration(milliseconds: 500));
//    timerRunning = true;
  }

  Future getCount() async {
    var value;
    await roomRef4.once().then((DataSnapshot dataSnapshot) {
      value = dataSnapshot.value;

      String counts = value.toString();
      count = int.parse(counts);
    });
  }

  Future getEndTime() async {
    var value;
    await roomRef2.once().then((DataSnapshot dataSnapshot) {
      value = dataSnapshot.value;

      String time = value.toString();
      endTime = DateTime.parse(time);
      print(endTime);
    });
    //currentTime = DateTime.now();
  }

  Widget upDate() {
    var value;
    var key;

//    setState(() {
//      getCurrentTime();
//      //currentTime = DateTime.now();
//    });
    if (getCurrentTime().isAfter(endTimesubstract) &&
        getCurrentTime().isBefore(endTimeplus)) {
      if (count >= 5) {
        print('loading');
        Navigator.pushNamed(context, LoadingScreen.id);
      } else {
        Navigator.pushNamed(context, RoomScreen.id);
      }
    } else if (getCurrentTime().isBefore(endTime)) {
      print('up');
      print(getCurrentTime());
      roomRef3.update(
        {'currentTime': getCurrentTime().toString()},
      );
      return waiting();
    } else {
      //Navigator.pop(context);
      Navigator.pushNamed(context, LoginScreen.id);
    }

    return Container();
  }

  Widget upDateNew() {
    var value;
    var key;

//    setState(() {
//      getCurrentTime();
//      //currentTime = DateTime.now();
//    });
    if (getCurrentTime().isBefore(endTime)) {
      print('up');
      print(getCurrentTime());
      roomRef3.update(
        {'currentTime': getCurrentTime().toString()},
      );
      return waiting();
    } else {
      timerRunning = false;
    }

    return Container();
  }

  DateTime getCurrentTime() {
    return DateTime.now();
  }

  Widget loading() {
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

  Widget waiting() {
    return Column(
      children: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Text(
            'WAITING FOR OTHER MEMBERS TO JOIN',
            style: kSendButtonTextStyle,
          ),
        ),
        Center(
          child: Text(getCurrentTime().toString()),
        ),
      ],
    );
  }

  bool getTimeRunning() {
    return timerRunning;
  }

  Widget getButton() {
    setState(() {
      getTimeRunning();
    });
    if (getCurrentTime().isAfter(endTime)) {
      if (count >= 5) {
        print('loading');
        return FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, LoadingScreen.id);
          },
          child: Text(
            'TIME STARTED ! SOON MOVING TO GAME SCREEN !',
            style: kSendButtonTextStyle,
          ),
        );
      } else {
        Navigator.pushNamed(context, LoginScreen.id);
      }
      return FlatButton();
    } else {
      return FlatButton(
        child: Text(
          'Waiting',
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.green,
      );
    }
  }

//  Widget textToDisplay() {
//
//    if (count >= 5) {
//      return Column(
//        children: <Widget>[
//          FlatButton(
//            onPressed: () {},
//            child: Text(
//              'TIME STARTED ! SOON MOVING TO GAME SCREEN !',
//              style: kSendButtonTextStyle,
//            ),
//          ),
//          Center(
//            child: Countdown(
//              seconds: 10,
//              build: (_, timer) => Text(timer.toString()),
//              interval: Duration(
//                milliseconds: 100,
//              ),
//              onFinished: () {
//                print('Timer is done!');
//                Navigator.pushNamed(context, CommonScreen.id);
//              },
//            ),
//          ),
//        ],
//      );
//    } else {
//      return FlatButton(
//        child: Text(
//          'WAITING FOR OTHER MEMBERS TO JOIN',
//          style: kSendButtonTextStyle,
//        ),
//      );
//    }
//  }

  Widget finalUpdate() {
    int val = endTime.compareTo(getCurrentTime());
    if (val > 0) {
      Duration duration = endTime.difference(getCurrentTime());
      int sec = duration.inSeconds;
      return Center(
        child: Countdown(
          seconds: sec,
          build: (_, timer) => Text(timer.toString()),
          interval: Duration(
            milliseconds: 100,
          ),
          onFinished: () async {
            print('Timer is done!');
            Future a = await getCount();
            if (count >= 5) {
              Navigator.pushNamed(context, CommonScreen.id);
            } else {
              Navigator.pushNamed(context, LoginScreen.id);
            }
          },
        ),
      );
    } else {
      Navigator.pushNamed(context, LoginScreen.id);
      return FlatButton();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MYSTERY GAME !!'),
      ),
      body: finalUpdate(),
//      body: Column(children: <Widget>[
//        TimerBuilder.scheduled([currentTime, endTime], builder: (context) {
//          return TimerBuilder.periodic(Duration(seconds: 1),
//              builder: (context) {
//            return upDateNew();
//          });
//        }),
//        getButton(),
//      ]),
    );
  }
}

String formatDuration(Duration d) {
  String f(int n) {
    return n.toString().padLeft(2, '0');
  }

  // We want to round up the remaining time to the nearest second
  d += Duration(microseconds: 999999);
  return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
}
