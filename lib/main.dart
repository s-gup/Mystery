import 'dart:ffi';

import 'package:flash_chat/screens/common_screen.dart';
import 'package:flash_chat/screens/fifth_screen.dart';
import 'package:flash_chat/screens/first_screen.dart';
import 'package:flash_chat/screens/fourth_screen.dart';
import 'package:flash_chat/screens/id_screen.dart';
import 'package:flash_chat/screens/join_screen.dart';
import 'package:flash_chat/screens/loading_screen.dart';
import 'package:flash_chat/screens/result_screen.dart';
import 'package:flash_chat/screens/room_screen.dart';
import 'package:flash_chat/screens/second_screen.dart';
import 'package:flash_chat/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'screens/waiting_room.dart';

import 'screens/chat_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/result_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/team.dart';
import 'screens/instruct.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
      //initialRoute: ChatScreen.id,
      initialRoute: WelcomeScreen.id,
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        FirstScreen.id: (context) => FirstScreen(),
        SecondScreen.id: (context) => SecondScreen(),
        FourthScreen.id: (context) => FourthScreen(),
        FifthScreen.id: (context) => FifthScreen(),
        //JoinScreen.id: (context) => JoinScreen(),
        IdScreen.id: (context) => IdScreen(),
        //RoomScreen.id: (context) => RoomScreen(),
        CommonScreen.id: (context) => CommonScreen(),
        TeamScreen.id: (context) => TeamScreen(),
        InstructScreen.id: (context) => InstructScreen(),
      },
    );
  }
}
