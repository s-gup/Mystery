import 'package:flutter/material.dart';
import 'package:screen/screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/common_screen.dart';
import 'package:flash_chat/screens/fifth_screen.dart';
import 'package:flash_chat/screens/join_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'waiting_room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'count_perroom.dart';
import 'back_end.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/waiting_room.dart';
import 'user.dart';
import 'package:flash_chat/screens/waiting_room.dart';
import 'package:getflutter/getflutter.dart';
import 'theme_screen.dart';
import 'package:dropdownfield/dropdownfield.dart';

class ChoiceScreen extends StatefulWidget {
  final email;
  final id;
  ChoiceScreen({this.email, this.id});
  @override
  _ChoiceScreenState createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  String email;
  DatabaseReference roomRef;
  String total = '3';
  String id;
//  List<String> p = ['3333', '4', '4111', '555'];
//  Map<String, dynamic> formData;
//  _ChoiceScreenState() {
//    formData = {
//      'player': '3',
//    };
//  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    Screen.keepOn(true);
    var value;
    //setTime();
    email = widget.email.toString();
    id = widget.id.toString();
  }

  Future updateTotal() async {
    roomRef = FirebaseDatabase.instance.reference().child('roomList').child(id);
    await roomRef.update(
      {'total': total.trim()},
    );
    print('totalpart$total');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 30.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
//            TextField(
//              textAlign: TextAlign.center,
//              style: TextStyle(
//                color: Colors.black,
//              ),
//              onChanged: (value) {
//                //Do something with the user input.
//                total = value;
//              },
//              decoration: InputDecoration(
//                hintText: 'Enter the size of room',
//                hintStyle: TextStyle(
//                  color: Colors.black54,
//                ),
//                contentPadding:
//                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                border: OutlineInputBorder(
//                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                ),
//                enabledBorder: OutlineInputBorder(
//                  borderSide:
//                      BorderSide(color: Colors.lightBlueAccent, width: 1.0),
//                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                ),
//                focusedBorder: OutlineInputBorder(
//                  borderSide:
//                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
//                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                ),
//              ),
//            ),
              DropdownButton<String>(
                value: total,
                icon: Icon(
                  Icons.arrow_downward,
                  color: Colors.black,
                ),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                hint: Text(
                  'select room size *',
                  style: TextStyle(color: Colors.red),
                ),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    total = newValue;
                  });
                },
                items: <String>['3', '4']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              //   Divider(height: 10.0, color: Theme.of(context).primaryColor),
//              DropDownField(
//                  value: formData['player'],
//                  required: true,
//                  strict: false,
//                  labelText: 'Size of room *',
//                  icon: Icon(Icons.account_balance),
//                  items: p,
//                  setter: (dynamic newValue) {
//                    formData['player'] = newValue;
//                  }),

              SizedBox(
                height: 24.0,
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
                      //total = formData['player'].toString();
                      Future a = await updateTotal();

                      //TODO: to theme screen
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ThemeScreen(
                          id: id,
                          email: email,
                          //total: total,
                        );
                      }));
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Select',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
