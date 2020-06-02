import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'registration_screen.dart';

class FifthScreen extends StatefulWidget {
  FifthScreen({this.protein,this.proteinseq});
  static const String id='fifth_screen';
  final protein;
  final proteinseq;
  @override
  _FifthScreenState createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {

                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('Results Screen:'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'TARGET PROTEIN:${widget.protein}',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'TARGET PROTEIN SEQUENCE:${widget.proteinseq}',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
