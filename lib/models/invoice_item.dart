import 'package:flutter/material.dart';

class InvoiceItem {
  final String name;
  final String description;

  InvoiceItem({
    @required this.name,
    @required this.description,
  });

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      name: json['name'],
      description: json['description']
    );
  }
}
