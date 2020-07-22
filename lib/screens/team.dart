import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'chat_screen.dart';
import 'hints.dart';
import 'package:flash_chat/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flipping_card/flipping_card.dart';
import 'timer.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:timer_count_down/timer_controller.dart';

class TeamScreen extends StatefulWidget {
  static const String id = 'team_screen';
  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  CardSide _card1Side = CardSide.FrontSide;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('About The Team'),
          backgroundColor: Colors.green,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/team1.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: Center(
              child: Text(
                  'Developed by :\n    Shelly Gupta\n    Bhavik Agarwal \n \nContent Team Leader: \n    Aryaman Babbar\n \n Content Team:\n    Hridyansh Gautam\n    Drishan Bhatia\n    Aditya Sharma\n    Akshit Mehra\n    Neeraj Chand\n    Shiwam Birajdar ',
                  style: TextStyle(
                    fontFamily: 'Spartan MB',
                    fontSize: 20.0,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.left)),
        ),
      ),
    );
  }
}
