import 'package:flutter/material.dart';
import 'package:flash_chat/screens/login_screen.dart';

class ResultScreen extends StatefulWidget {
  static const String id = 'result_screen';
  final userAnswer;
  ResultScreen({this.userAnswer});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String answer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    answer = widget.userAnswer;
  }

  Widget getAnswer() {
    if (answer == '5') {
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
                onTap: () => Navigator.pushNamed(context, LoginScreen.id),
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
