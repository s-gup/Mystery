import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'hints.dart';
import 'package:flash_chat/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flipping_card/flipping_card.dart';
import 'timer.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'package:timer_count_down/timer_controller.dart';

class HintScreen extends StatefulWidget {
  final hintKey;
  final hintType;
  final idd;

  HintScreen({this.hintKey, this.hintType, this.idd});

  @override
  _HintScreenState createState() => _HintScreenState();
}

class _HintScreenState extends State<HintScreen> {
  int key;
  HintModel hintModel = HintModel();
  CardSide _card1Side = CardSide.FrontSide;
  String commonMessage;

  String hintMessage;
  String id;
  bool type;
  @override
  void initState() {
    super.initState();
    key = widget.hintKey;
    id = widget.idd;
    type = widget.hintType;
    print(key);
    print(type);
    print(id);
    print(type == true);
    if (type == true) {
      print('entered true');
      hintMessage = hintModel.getTrueHint(key);
    } else {
      print('false en');
      hintMessage = hintModel.getFalseHint(key);
    }
    print(hintMessage);
    commonMessage =
        'Mr X has been murdered !!!  You have to identify the killer out of five people . Click on this page to get the hint about the Character $key !! ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/detect2.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
//                  FlatButton(
//                    onPressed: () {
//                      Navigator.pushNamed(context, ChatScreen.id);
//                    },
//                    child: Icon(
//                      Icons.chat,
//                      size: 50.0,
//                    ),
//                  ),

//
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$key : ',
                      style: kTempTextStyle,
                    ),
                    Countdown(
                      seconds: 180,
                      build: (_, timer) => Text(timer.toString()),
                      interval: Duration(
                        milliseconds: 100,
                      ),
                      onFinished: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ChatScreen(
                            idd: id,
                          );
                        }));
                        print('50 s completete codkcedkior!');
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FlippingCard(
                  frontChild: Container(
                      width: 200,
                      height: 450,
                      color: Colors.transparent,
                      child: Center(
                        child: AutoSizeText(
                          commonMessage,
                          style: kMessageTextStyle,
                        ),
                      )),
                  backChild: Container(
                      width: 200,
                      height: 450,
                      color: Colors.transparent,
                      child: Center(
                        child: AutoSizeText(
                          hintMessage,
                          style: kMessageTextStyle,
                        ),
                      )),
                  side: _card1Side,
                  onTap: (side) {
                    setState(() {
                      _card1Side = (side == CardSide.FrontSide)
                          ? CardSide.BackSide
                          : CardSide.FrontSide;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
