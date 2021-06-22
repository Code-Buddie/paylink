import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String email;
  final bool loggedIn;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.loggedIn,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        loggedIn: false);
  }
}
