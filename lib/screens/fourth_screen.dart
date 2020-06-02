import 'package:flash_chat/screens/fifth_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
FirebaseUser loggin;
class FourthScreen extends StatefulWidget {
  static const String id='fourth_screen';
  @override
  _FourthScreenState createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  final messageTextController=TextEditingController();
  final _firestore=Firestore.instance;
  String messagetext;
  final _auth=FirebaseAuth.instance;
  String id;
  String protein;
  String proteinseq;

  void messagesStream() async{
    bool res=false;
    await for(var snapshot in _firestore.collection('newdrugs').snapshots()){
      for(var message in snapshot.documents ){

        if(message.data['id']==id.trim()){
          protein=message.data['protein'];
          proteinseq=message.data['proteinseq'];
          print(protein);
          print(proteinseq);
          res=true;
          break;
        }
      }
      if(res){
        break;
      }
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FifthScreen(
        protein: protein,
        proteinseq: proteinseq,
      );
    }));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

      body: Container(
        color: Colors.pinkAccent,
        child: SafeArea(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[

              Container(
                decoration: kMessageContainerDecoration,

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'ENTER YOUR DRUG BANK ID:',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),

                    Expanded(
                      child: TextField(

                        style: TextStyle(
                          color: Colors.black,
                        ),
                        controller: messageTextController,
                        onChanged: (value) {

                          id=value;
                          //Do something with the user input.
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        messageTextController.clear();
                        messagesStream();
                        //Implement send functionality.
                      },
                      child: Text(
                        'Get Result',
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
