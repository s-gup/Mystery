import 'package:flutter/material.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/services.dart';

class ResultScreen extends StatefulWidget {
  static const String id = 'result_screen';
  final userAnswer;
  final actualAnswer;
  ResultScreen({this.userAnswer, this.actualAnswer});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String answer;
  String actualAnswer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    answer = widget.userAnswer;
    actualAnswer = widget.actualAnswer;
  }

  Widget getAnswer() {
    if (answer == actualAnswer) {
      return Center(
        child: Icon(
          Icons.check,
          size: 40,
          color: Colors.green,
        ),
      );
    } else {
      return Center(
        child: Icon(
          Icons.clear,
          size: 40,
          color: Colors.red,
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
