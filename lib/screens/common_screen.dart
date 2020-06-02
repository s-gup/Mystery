import 'package:flash_chat/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'hint_screen.dart';

import 'login_screen.dart';
import 'registration_screen.dart';

class CommonScreen extends StatefulWidget {
  static const String id = 'common_screen';
  @override
  _CommonScreenState createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, LoginScreen.id);
                    //Go to login screen.
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HintScreen(
                        hintKey: 1,
                        hintType: true,
                      );
                    }));
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'CHARACTER 1',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    //Navigator.pushNamed(context, SecondScreen.id);
                    //Go to login screen.
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HintScreen(
                        hintKey: 2,
                        hintType: true,
                      );
                    }));
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'CHARACTER 2',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Navigator.pushNamed(context, RegistrationScreen.id);
                    //Go to registration screen.
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HintScreen(
                        hintKey: 3,
                        hintType: true,
                      );
                    }));
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'CHARACTER 3',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, RegistrationScreen.id);
                    //Go to registration screen.
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HintScreen(
                        hintKey: 4,
                        hintType: true,
                      );
                    }));
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'CHARACTER 4',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, RegistrationScreen.id);
                    //Go to registration screen.
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HintScreen(
                        hintKey: 5,
                        hintType: false,
                      );
                    }));
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'CHARACTER 5',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
