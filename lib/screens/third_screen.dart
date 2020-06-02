import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
FirebaseUser loggin;
class ThirdScreen extends StatefulWidget {
  static const String id='third_screen';
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final messageTextController=TextEditingController();
  final _firestore=Firestore.instance;
  String messagetext;
  String id;
  String protein;
  String proteinseq;
  final _auth=FirebaseAuth.instance;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
     loadAsset();


  }

  List<List<dynamic>> data = [];
  loadAsset() async {
    final myData = await rootBundle.loadString("csvfiles/finaloutput.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    print(csvTable[1][0]);
    data = csvTable;
    setState(() {

    });
    getCurrentUser();
  }
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggin = user;
        print(loggin.email);
        filldata();
      }
    }

    catch (e) {
      print(e);
    }
  }

  void filldata() async {

      for( int i=1;i<data.length;i++) {
        try {

          List<dynamic> l1 = data[i];
          id = l1[0];
          protein = l1[2];
          proteinseq = l1[3];
          print(id);
          print(protein);
          print(proteinseq);
          _firestore.collection('newdrugs').add({
            'id': id,
            'protein': protein,
            'proteinseq': proteinseq,
          });
        }
        catch (e) {
          print(e);
        }
      }
    }





  @override
  Widget build(BuildContext context) {
    return Scaffold(


    );
  }
}
