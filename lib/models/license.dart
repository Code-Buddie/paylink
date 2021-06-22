import 'package:flutter/material.dart';

class License {
  final String id;
  final String name;
  final String description;

  License({
    @required this.id,
    @required this.name,
    @required this.description,
  });

  factory License.fromJson(Map<String, dynamic> json) {
    return License(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}