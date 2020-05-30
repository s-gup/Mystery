import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
FirebaseUser loggin;
class ChatScreen extends StatefulWidget {
  static const String id='chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController=TextEditingController();
  final _firestore=Firestore.instance;
  String messagetext;
  final _auth=FirebaseAuth.instance;

  void messagesStream() async{
    await for(var snapshot in _firestore.collection('messages').snapshots()){
      for(var message in snapshot.documents ){
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
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggin = user;
        print(loggin.email);
      }
    }

    catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
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
                stream: _firestore.collection('messages').snapshots(),
                builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  final messages=snapshot.data.documents.reversed;
                  List<MessageBubble> messageWidgets=[];
                  for(var message in messages){
                    final messageText=message.data['text'];
                    final messagesender=message.data['sender'];
                    final currentUser=loggin.email;
                    final messagewidge=MessageBubble(sender: messagesender,text: messageText,isme: currentUser==messagesender,);
                    messageWidgets.add(messagewidge);
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0,),
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

                          messagetext=value;
                          //Do something with the user input.
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        messageTextController.clear();
                        _firestore.collection('messages').add({
                          'text':messagetext,
                           'sender':loggin.email,
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
  MessageBubble({this.sender,this.text,this.isme});
  final String sender;
  final String text;
  final bool isme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isme?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: <Widget>[
          Text(sender,style: TextStyle(
            fontSize: 12.0,
            color: Colors.black54,
          ),),
          Material(
            borderRadius: isme?BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ):BorderRadius.only(
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: isme?Colors.lightBlueAccent:Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0,),
              child: Text(text,style: TextStyle(
                color: isme?Colors.white:Colors.black,
                fontSize: 15.0,
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
