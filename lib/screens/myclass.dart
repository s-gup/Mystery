import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
var shelly=new Map();

class myclass{
  void addinmap(FirebaseAuth auth,String email){
     shelly[auth]=email;
  }
  String getfrommap(FirebaseAuth auth){
    return shelly[auth];
  }

}