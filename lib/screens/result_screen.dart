import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RESULT !!'),
      ),
      body: getAnswer(),
    );
  }
}
