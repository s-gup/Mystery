import 'package:flash_chat/screens/semi_final.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screen/screen.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'result_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'reusable_card.dart';
import 'icon_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'id_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:screen/screen.dart';

class ThemeScreen extends StatefulWidget {
  final email;
  final id;
  final total;
  ThemeScreen({this.email, this.id, this.total});
  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  String selectedCard; // 0 for fun and 1 for logic
  int set = 50;
  String email;
  DatabaseReference roomRef;
  String total;
  String id;
  int player;
  List<String> hints;
  String ansq;
  String commonMessage;

  final _firestore = Firestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Screen.keepOn(true);
    var value;
    //setTime();
    email = widget.email.toString();
    id = widget.id.toString();
    total = widget.total;
    player = int.parse(total);
    hints = List();
  }

  Future hintsStream() async {
    await for (var snapshot
        in _firestore.collection('players$player').snapshots()) {
      for (var message in snapshot.documents) {
        if (message.documentID == 'fun3') {
          await for (var snapshot2
              in _firestore.collection(message.data['fun3']).snapshots()) {
            for (var m in snapshot2.documents) {
              if (m.documentID == set.toString()) {
                for (int i = 1; i < 3; i++) {
                  hints.add(m.data[i.toString().trim()].toString());
                  ansq = m.data['ans'].toString().trim();
                  print(hints);
                }
              }
            }
          }
        }
      }
    }
  }

  Future hello() async {
//    final d = await _firestore.collection('players3').document('fun3').get();
//    print(d.data['fun3']);

//    await Firestore.instance
//        .collection('players3')
//        .where('ref', isEqualTo: 'collections/fun3')
//        .getDocuments()
//        .then((doc) {
//      print(doc.toString());
//
//      //final ref_value = doc.documents[0][1];
//      for (var message in doc.documents) {
//        print(message.data);
//      }
//    });
    await for (var snapshot
        in _firestore.collection('$selectedCard$total').snapshots()) {
      for (var message in snapshot.documents) {
        if (message.documentID.toString().trim() == set.toString()) {
          for (int i = 1; i <= int.parse(total); i++) {
            hints.add(message.data[i.toString()].toString());
            print(message.data[i.toString()]);
            print(hints);
            ansq = message.data['ans'].toString().trim();
            commonMessage = message.data['common'].toString().trim();
          }
          Future a = await addToHintList();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return IdScreen(roomId: id, email: email);
          }));
        }
      }
    }
    print(hints);
  }

  Future updateThemeSet() async {
    roomRef = FirebaseDatabase.instance.reference().child('roomList').child(id);
    await roomRef.update(
      {'theme': selectedCard, 'set': set.toString()},
    );
    print('totalpart$total');
  }

  Future addToHintList() async {
    print('hello');
    String changed = jsonEncode(hints);
    roomRef = FirebaseDatabase.instance.reference().child('roomList').child(id);
    await roomRef.update(
      {
        'hints': changed,
        'actualAns': ansq,
        'theme': selectedCard,
        'set': set.toString(),
        'common': commonMessage,
      },
    );
    print('listupdated$changed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SELECT THEME'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
//              mainAxisSize: MainAxisSize.min,
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedCard = 'logic';
                      });
                    },
                    colour: selectedCard == 'logic'
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    cardChild: IconContents(
                      icon: FontAwesomeIcons.mars,
                      label: 'LOGIC',
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedCard = 'fun';
                      });
                    },
                    colour: selectedCard == 'fun'
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    cardChild: IconContents(
                      icon: FontAwesomeIcons.venus,
                      label: 'FUN',
                    ),
                  ),
                )
              ],
            )),
            Expanded(
              child: ReusableCard(
                colour: kActiveCardColor,
                cardChild: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'NUMBER',
                        style: kLabelTestStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            set.toString(),
                            style: kNumberTextStyle,
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          inactiveTrackColor: Color(0xFF8D8E98),
                          thumbColor: Color(0xFFEB1555),
                          activeTrackColor: Colors.white,
                          overlayColor: Color(0x29EB1555),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 15.0),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 30.0),
                        ),
                        child: Slider(
                          value: set.toDouble(),
                          min: 1.0,
                          max: 100.0,
                          onChanged: (double newValue) {
                            setState(() {
                              set = newValue.round();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  //Future a = await updateThemeSet();
                  Future b = await hello();
                  //Future c = await addToHintList();
//                  await Navigator.push(context,
//                      MaterialPageRoute(builder: (context) {
//                    return IdScreen(roomId: id, email: email);
//                  }));
                  //Go to login screen.
                },
                child: Container(
                  child: Center(
                    child: Text(
                      'SUBMIT',
                      style: kLargeButtonTextStyle,
                    ),
                  ),
                  width: double.infinity,
                  height: kBottomContainerHeight,
                  color: kBottomContainerColor,
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.only(bottom: 20.0),
                ),
              ),
            )
          ],
        ));
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({this.icon, this.onPress});
  final IconData icon;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPress,
      child: Icon(icon),
      elevation: 0.0,
      constraints: BoxConstraints.tightFor(width: 56.0, height: 56.0),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}
