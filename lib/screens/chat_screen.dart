//import 'dart:html';

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

FirebaseUser loggin;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  final idd;
  ChatScreen({this.idd});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final messageTextController = TextEditingController();
  final _firestore = Firestore.instance;
  String messagetext;
  bool _isKeptOn = false;
  double _brightness = 1.0;
  final _auth = FirebaseAuth.instance;
  DatabaseReference roomRef;
  DatabaseReference roomRef2;

  String idd;
  String leader;
  String currentMail;
  bool gotMessage = false;
  ProgressDialog pr;
  String answer = '';
  String actualAns = '';
  String explanation;
  bool submitted = false;
  void messagesStream() async {
    await for (var snapshot in _firestore.collection(idd).snapshots()) {
      for (var message in snapshot.documents) {
        print(message.data);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    Screen.keepOn(true);
    print("hello");
    getCurrentUser();
    idd = widget.idd;
    pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
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

  initPlatformState() async {
    bool keptOn = await Screen.isKeptOn;
    double brightness = await Screen.brightness;
    setState(() {
      _isKeptOn = keptOn;
      _brightness = brightness;
    });
  }

  Future updateAnswer() async {
    roomRef2 =
        FirebaseDatabase.instance.reference().child('roomList').child(idd);
    await roomRef2.update(
      {'answer': answer},
    );
  }

  Future getSavedAnswer() async {
    roomRef = FirebaseDatabase.instance
        .reference()
        .child('roomList')
        .child(idd)
        .child('answer');
    var value;
    await roomRef.once().then((DataSnapshot dataSnapshot) {
      value = dataSnapshot.value;

      answer = value.toString().trim();
      print(answer);
    });
  }

  Future getExplanation() async {
    roomRef = FirebaseDatabase.instance
        .reference()
        .child('roomList')
        .child(idd)
        .child('explanation');
    var value;
    await roomRef.once().then((DataSnapshot dataSnapshot) {
      value = dataSnapshot.value;

      explanation = value.toString().trim();
    });
  }

  Future getActualAnswer() async {
    roomRef = FirebaseDatabase.instance
        .reference()
        .child('roomList')
        .child(idd)
        .child('actualAns');
    var value;
    await roomRef.once().then((DataSnapshot dataSnapshot) {
      value = dataSnapshot.value;

      actualAns = value.toString().trim();
      print(answer);
    });
  }

  Future showingProgress() async {
    pr.style(
        message: 'waiting...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    await pr.show();
  }

  Future getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggin = user;
        print(loggin.email);
        currentMail = loggin.email;
      }
    } catch (e) {
      print(e);
    }
  }

  Future getLeader() async {
    roomRef = FirebaseDatabase.instance
        .reference()
        .child('roomList')
        .child(idd)
        .child('leader');
    var value;
    await roomRef.once().then((DataSnapshot dataSnapshot) {
      value = dataSnapshot.value;

      leader = value.toString();
    });
  }

  createAlertDialog(BuildContext context) async {
    TextEditingController customController = TextEditingController();

    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height / 3,
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Your Answer ?",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    Material(
                      color: Colors.black26,
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your answer'),
                        controller: customController,
                      ),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        answer = customController.text.toString();
                        Future a = await updateAnswer();
                        submitted = true;
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ResultScreen(
                            userAnswer: answer,
                            actualAnswer: actualAns,
                            explanation: explanation,
                          );
                        }));
                      },
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: const Color(0xFF1BC0C5),
                    ),
                    Countdown(
                        seconds: 30,
                        build: (_, timer) => Text(
                              timer.toString(),
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                        interval: Duration(
                          milliseconds: 100,
                        ),
                        onFinished: () async {
                          if (submitted == false) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ResultScreen(
                                userAnswer: answer,
                                actualAnswer: actualAns,
                                explanation: explanation,
                              );
                            }));
                          }
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }

  createAlertDialog1(BuildContext context) async {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Your Answer ?"),
            content: TextField(
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Submit'),
                onPressed: () async {
                  answer = customController.text.toString();
                  Future a = await updateAnswer();
                  submitted = true;
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ResultScreen(
                      userAnswer: answer,
                      actualAnswer: actualAns,
                      explanation: explanation,
                    );
                  }));
                  //Navigator.pop(context);

//                  setState(() {
//                    gotMessage = true;
//                    Navigator.pop(context);
//                  });
                },
              ),
              Countdown(
                  seconds: 30,
                  build: (_, timer) => Text(timer.toString()),
                  interval: Duration(
                    milliseconds: 100,
                  ),
                  onFinished: () async {
                    if (submitted == false) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ResultScreen(
                          userAnswer: answer,
                          actualAnswer: actualAns,
                          explanation: explanation,
                        );
                      }));
                    }
                  }),
            ],
          );
        });
  }

  createWaitAlertDialog(BuildContext context) async {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height / 3,
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    'Waiting for leader to submit the answer !!',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  Center(
                    child: Countdown(
                        seconds: 35,
                        build: (_, timer) => Text(
                              timer.toString(),
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                        interval: Duration(
                          milliseconds: 100,
                        ),
                        onFinished: () async {
                          Future a = await getSavedAnswer();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ResultScreen(
                              userAnswer: answer,
                              actualAnswer: actualAns,
                              explanation: explanation,
                            );
                          }));
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  createWaitAlertDialog1(BuildContext context) async {
    //TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Waiting for leader to put answer"),
            actions: <Widget>[
              Center(
                child: Countdown(
                    seconds: 35,
                    build: (_, timer) => Text(timer.toString()),
                    interval: Duration(
                      milliseconds: 100,
                    ),
                    onFinished: () async {
                      Future a = await getSavedAnswer();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ResultScreen(
                          userAnswer: answer,
                          actualAnswer: actualAns,
                          explanation: explanation,
                        );
                      }));
                    }),
              ),
            ],
          );
        });
  }

  Widget hello() {
    if (gotMessage == false) {
      return Countdown(
        seconds: 20,
        build: (_, timer) => Text(timer.toString()),
        interval: Duration(
          milliseconds: 100,
        ),
        onFinished: () async {
          //TODO: move to result screen
          print('20 s completete codkcedkior!');
          Row();
          Future a = await getLeader();
          Future b = await getCurrentUser();
          leader = leader.trim();
          currentMail = currentMail.trim();
          print(leader);
          print(currentMail);
          print(currentMail == leader);
          if (currentMail == leader) {
            await createAlertDialog(context);
          } else {
            await showingProgress();
          }
        },
      );
    } else {
      pr.hide();
      return FlatButton(
        child: Text('get Result', style: kMessageTextStyle),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ResultScreen(
              userAnswer: answer,
            );
          }));
        },
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
                // Navigator.pushNamed(context, LoginScreen.id),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget getAnswer() {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Center(
        child: Countdown(
            seconds: 600,
            //600,
            build: (_, timer) => Text(timer.toString()),
            interval: Duration(
              milliseconds: 1000,
            ),
            onFinished: () async {
              Future a = await getLeader();
              Future b = await getCurrentUser();
              Future c = await getActualAnswer();
              Future d = await getExplanation();
              leader = leader.trim();
              currentMail = currentMail.trim();
              if (currentMail == leader) {
                await createAlertDialog(context);
//            Countdown(
//                seconds: 10,
//                build: (_, timer) => Text(timer.toString()),
//                interval: Duration(
//                  milliseconds: 100,
//                ),
//                onFinished: () async {
//                  Navigator.push(context, MaterialPageRoute(builder: (context) {
//                    return ResultScreen(
//                      userAnswer: answer,
//                    );
//                  }));
//                });

              } else {
                await createWaitAlertDialog(context);
//            Countdown(
//                seconds: 13,
//                build: (_, timer) => Text(timer.toString()),
//                interval: Duration(
//                  milliseconds: 100,
//                ),
//                onFinished: () async {
//                  Future a = await getSavedAnswer();
//                  Navigator.push(context, MaterialPageRoute(builder: (context) {
//                    return ResultScreen(
//                      userAnswer: answer,
//                    );
//                  }));
//                });
              }
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: getAnswer(),
//        actions: <Widget>[
//          IconButton(
//              icon: Icon(Icons.close),
//              onPressed: () {
//                _auth.signOut();
//                Navigator.pop(context);
//                //Implement logout functionality
//              }),
//        ],
        title: Text('Discussion Room'),
        backgroundColor: Colors.black45,
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection(idd)
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  final messages = snapshot.data.documents;
                  List<MessageBubble> messageWidgets = [];
                  for (var message in messages) {
                    final messageText = message.data['text'].toString();
                    final messagesender = message.data['sender'].toString();
                    final currentUser = loggin.email;
                    final messagewidge = MessageBubble(
                      sender: messagesender,
                      text: messageText,
                      isme: currentUser == messagesender,
                    );
                    messageWidgets.add(messagewidge);
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 20.0,
                      ),
                      children: messageWidgets,
                    ),
                  );
                },
              ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        controller: messageTextController,
                        onChanged: (value) {
                          messagetext = value;
                          //Do something with the user input.
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        messageTextController.clear();
                        _firestore.collection(idd).add({
                          'text': messagetext,
                          'sender': loggin.email,
                          'timestamp': DateTime.now().millisecondsSinceEpoch,
                        });
                        //Implement send functionality.
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isme});
  final String sender;
  final String text;
  final bool isme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isme
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isme ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isme ? Colors.white : Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
