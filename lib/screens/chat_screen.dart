import 'package:flash_chat/screens/semi_final.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'result_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flash_chat/constants.dart';

FirebaseUser loggin;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  final idd;
  ChatScreen({this.idd});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _firestore = Firestore.instance;
  String messagetext;
  final _auth = FirebaseAuth.instance;
  DatabaseReference roomRef;
  DatabaseReference roomRef2;

  String idd;
  String leader;
  String currentMail;
  bool gotMessage = false;
  ProgressDialog pr;
  String answer = '';

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.documents) {
        print(message.data);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("hello");
    getCurrentUser();
    idd = widget.idd;
    pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
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

      answer = value.toString();
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ResultScreen(
                      userAnswer: answer,
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
                  seconds: 600,
                  build: (_, timer) => Text(timer.toString()),
                  interval: Duration(
                    milliseconds: 100,
                  ),
                  onFinished: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ResultScreen(
                        userAnswer: answer,
                      );
                    }));
                  }),
            ],
          );
        });
  }

  createWaitAlertDialog(BuildContext context) async {
    //TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Waiting for leader to put answer"),
            actions: <Widget>[
              Countdown(
                  seconds: 13,
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
                      );
                    }));
                  }),
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

  Widget getAnswer() {
    return Countdown(
        seconds: 20,
        build: (_, timer) => Text(timer.toString()),
        interval: Duration(
          milliseconds: 100,
        ),
        onFinished: () async {
          Future a = await getLeader();
          Future b = await getCurrentUser();
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: getAnswer(),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.black,
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
                    .collection('messages')
                    .orderBy('date')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  final messages = snapshot.data.documents.reversed;
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
                        _firestore.collection('messages').add({
                          'text': messagetext ?? '',
                          'sender': loggin.email,
                          'date': DateTime.now().toIso8601String().toString(),
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
