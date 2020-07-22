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

class InstructScreen extends StatefulWidget {
  static const String id = 'instruct_screen';
  @override
  _InstructScreenState createState() => _InstructScreenState();
}

class _InstructScreenState extends State<InstructScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Instructions : '),
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
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Center(
                          child: Text(
                              '1.)	Game objective:\nA team of 3-4 people solve puzzles and mysteries (logical and fun) in a virtual chatroom. The team then works on the puzzle by working on the different hints given.\n2.)	Game content:\nPuzzles and Mysteries (logical and fun) , Individual clues , Inbuilt chatroom discussions\n3.)	Game assembly:\nInternet connectivity required\n4.)	Game setup:\nNew users will have to register with a username and a minimum 6-digit password. Then the registered users will login with the same credentials.\n5.)	Game Play:\nAfter logging in, user will have two options-\nCreate Room\nJoin Room.\n•	Choose number of players (3 or 4) Choose theme (fun or logic) Acquire the Room Id  Share it with your friends.\n•	Your friends can join the Room by entering with the same Room Id.\n•	Room will be open for 3 minutes.\n•	Each player of the team will receive separate hints for puzzles.\n•	Analyse the hint in 3 minutes. Observe and analyse the hint carefully as it will be accessible only within that time frame of 3 minutes.\n•	You will be redirected to a chat screen where you can discuss hints with your friends and try to find the answer.  After 10 minutes, the leader (who created the room) will have the option to answer within 35 seconds.\n6.)	Special Condition:\n•	After joining the Game Room, if the application goes in background state i.e. the app is minimized (like a user is on phone call etc.), the particular user will be kicked out of the Game Room and will not be able to continue the further quest with his team.\n•	If the specified number of players don\'t join the room within 3 minutes time frame, Room will be destroyed and you have to start from beginning.\n7.)	Winning:\nAfter 10 minutes, leader (who created the room) will have the option to answer within 35 seconds. If he types the answer correctly the team will be the winner.\n8.)	Gameplay variations:\n3 players or 4 players.\n9.)	Strategy tips:\nMost of the answers will be one word unless specified otherwise.',
                              style: TextStyle(
                                fontFamily: 'Spartan MB',
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left)),
                    ),
                  ],
                ),
              ),
            )));
  }
}
