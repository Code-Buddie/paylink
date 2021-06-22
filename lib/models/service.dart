import 'package:flutter/material.dart';

class Service {
  final String id;
  final String name;

  Service({
    @required this.id,
    @required this.name,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
    );
  }
}