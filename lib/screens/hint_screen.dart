import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'chat_screen.dart';
import 'hints.dart';
import 'package:flash_chat/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flipping_card/flipping_card.dart';
import 'timer.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:timer_count_down/timer_controller.dart';

class HintScreen extends StatefulWidget {
  final hintKey;
  final message;
  final idd;
  final commonMessage;

  HintScreen({this.idd, this.message, this.commonMessage, this.hintKey});

  @override
  _HintScreenState createState() => _HintScreenState();
}

class _HintScreenState extends State<HintScreen> with WidgetsBindingObserver {
  int key;
  HintModel hintModel = HintModel();
  CardSide _card1Side = CardSide.FrontSide;
  String commonMessage;

  String hintMessage;
  String id;
  //bool type;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    key = widget.hintKey;
    id = widget.idd;
    //type = widget.hintType;
    print(key);
    //print(type);
    print(id);
    //print(type == true);
//    if (type == true) {
//      print('entered true');
//      hintMessage = hintModel.getTrueHint(key);
//    } else {
//      print('false en');
//      hintMessage = hintModel.getFalseHint(key);
//    }
//    print(hintMessage);
    hintMessage = widget.message.toString();

    /*commonMessage =
        'Mr X has been murdered !!!  You have to identify the killer out of five people . All the suspects know each other. Click on this page to get the hint about the Character $key !! ';*/
    commonMessage = widget.commonMessage.toString();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // user returned to our app
    } else if (state == AppLifecycleState.inactive) {
      print('inactive');
      SystemNavigator.pop();
      // app is inactive
    } else if (state == AppLifecycleState.paused) {
      print('paused');
      SystemNavigator.pop();
      // user is about quit our app temporally
    } else if (state == AppLifecycleState.detached) {
      // app suspended (not used in iOS)
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
                        //120
                        seconds: 180,
                        build: (_, timer) => Text(
                          timer.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        interval: Duration(
                          milliseconds: 1000,
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
      ),
    );
  }
}
