import 'package:flutter/rendering.dart';

class User {
  String email;
  String code;

  User(this.email, this.code);

  Map toJson() => {
        'email': email,
        'code': code,
      };

  factory User.fromJson(dynamic json) {
    return User(json['email'] as String, json['code'] as String);
  }
  @override
  String toString() {
    return '{ ${this.email}, ${this.code} }';
  }
}
