import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/services.dart';
import 'package:flash_chat/constants.dart';
import 'room_screen.dart';

class ResultScreen extends StatefulWidget {
  static const String id = 'result_screen';
  final userAnswer;
  final actualAnswer;
  final explanation;
  ResultScreen({this.userAnswer, this.actualAnswer, this.explanation});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String answer;
  String actualAnswer;
  String explanation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    answer = widget.userAnswer;
    actualAnswer = widget.actualAnswer;
    explanation = widget.explanation;
  }

  Widget getAnswer() {
    if (answer.trim().toLowerCase() == actualAnswer.trim().toLowerCase()) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/result.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'CORRECT ANSWER',
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.green,
                        fontWeight: FontWeight.w900),
                  ),
                  Center(
                    child: Icon(
                      Icons.check,
                      size: 40,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Your Team Answer : ',
                      style: TextStyle(
                        fontFamily: 'Spartan MB',
                        fontSize: 30.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    Card(
                      color: Colors.lightBlue,
                      child: AutoSizeText(
                        answer,
                        style: TextStyle(
                          fontFamily: 'Spartan MB',
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Correct Answer : ',
                      style: TextStyle(
                        fontFamily: 'Spartan MB',
                        fontSize: 30.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    Card(
                      color: Colors.lightBlue,
                      child: AutoSizeText(
                        actualAnswer,
                        style: TextStyle(
                          fontFamily: 'Spartan MB',
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Explanation : ',
                      style: TextStyle(
                        fontFamily: 'Spartan MB',
                        fontSize: 30.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    Card(
                      color: Colors.lightBlue,
                      child: Center(
                        child: AutoSizeText(
                          explanation,
                          style: TextStyle(
                            fontFamily: 'Spartan MB',
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: RaisedButton(
                  splashColor: Colors.pink,
                  elevation: 5,
                  color: Colors.pink,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RoomScreen();
                    }));
                    //Implement send functionality.
                  },
                  child: Text(
                    'PLAY AGAIN',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/result.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'WRONG ANSWER',
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.red,
                        fontWeight: FontWeight.w900),
                  ),
                  Center(
                    child: Icon(
                      Icons.clear,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Your Team Answer : ',
                      style: TextStyle(
                        fontFamily: 'Spartan MB',
                        fontSize: 30.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    Card(
                      color: Colors.lightBlue,
                      child: AutoSizeText(
                        answer,
                        style: TextStyle(
                          fontFamily: 'Spartan MB',
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Correct Answer : ',
                      style: TextStyle(
                        fontFamily: 'Spartan MB',
                        fontSize: 30.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    Card(
                      color: Colors.lightBlue,
                      child: AutoSizeText(
                        actualAnswer,
                        style: TextStyle(
                          fontFamily: 'Spartan MB',
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Explanation : ',
                      style: TextStyle(
                        fontFamily: 'Spartan MB',
                        fontSize: 30.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    Card(
                      color: Colors.lightBlue,
                      child: Center(
                        child: AutoSizeText(
                          explanation,
                          style: TextStyle(
                            fontFamily: 'Spartan MB',
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: RaisedButton(
                  splashColor: Colors.pink,
                  elevation: 5,
                  color: Colors.pink,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RoomScreen();
                    }));
                    //Implement send functionality.
                  },
                  child: Text(
                    'PLAY AGAIN',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
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
          title: Text('RESULT !!'),
        ),
        body: getAnswer(),
      ),
    );
  }
}
