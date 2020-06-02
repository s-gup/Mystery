import 'package:flash_chat/screens/fourth_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'registration_screen.dart';

class SecondScreen extends StatefulWidget {
  static const String id='second_screen';

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool checkedValue1=false;
  bool checkedValue2=false;
  bool checkedValue3=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CheckboxListTile(
              title: Text("Target Protein Names",style: TextStyle(color: Colors.black),),
              value: checkedValue1,
              activeColor: Colors.black,
              checkColor: Colors.red,
              onChanged: (newValue) {
                setState(() {
                  checkedValue1 = newValue;
                  print(checkedValue1);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
            ),
            CheckboxListTile(
              title: Text("Target Proteins Sequences",style: TextStyle(color: Colors.black),),
              value: checkedValue2,
              activeColor: Colors.black,
              checkColor: Colors.red,
              onChanged: (newValue) {
                setState(() {
                  checkedValue2 = newValue;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
            ),
            CheckboxListTile(
              title: Text("Molecular Pathways",style: TextStyle(color: Colors.black),),
              value: checkedValue3,
              activeColor: Colors.black,
              checkColor: Colors.red,
              onChanged: (newValue) {
                setState(() {
                  checkedValue3 = newValue;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.black,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, FourthScreen.id);
                    //Go to login screen.
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'NEXT',
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
