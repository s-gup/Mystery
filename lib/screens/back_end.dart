import 'package:firebase_database/firebase_database.dart';

class Room {
  String roomId;
  String key;
  List<Future> userList;
  int counter;
  //Countdown timer;

  Room(this.roomId, this.userList, this.counter);

  Room.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        roomId = snapshot.value['roomId'],
        userList = snapshot.value['userList'],
        counter = snapshot.value['counter'];
  toJson() {
    return {
      "userList": userList,
      "counter": counter,
    };
  }
}
