import 'package:flutter/material.dart';

class InvoiceItem {
  final String name;
  final String paidAt;
  final String description;

  InvoiceItem({
    @required this.name,
    @required this.paidAt,
    @required this.description,
  });

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(name: "debit", paidAt: "today", description: '200');
  }
}
