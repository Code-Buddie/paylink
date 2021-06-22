import 'package:flutter/material.dart';
import 'package:paylink_app/models/invoice_item.dart';

// part 'invoice.g.dart';

class Invoice {
  final String id;
  final String name;
  final String description;
  final String status;
  final List<InvoiceItem> invoiceItems;

  Invoice({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.status,
    @required this.invoiceItems,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      invoiceItems: (json['invoiceItems'] as List)
          .map((invoiceItem) => InvoiceItem.fromJson(invoiceItem))
          .toList(),
    );
  }
}
