import 'package:flutter/material.dart';
import 'package:paylink_app/models/invoice_item.dart';

// part 'invoice.g.dart';

class Invoice {
  final double balance;
  final List<InvoiceItem> invoiceItems;

  Invoice({
    @required this.balance,
    @required this.invoiceItems,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      balance: json['balance'],
      invoiceItems: (json['transactions'] as List).map((invoiceItem) => InvoiceItem.fromJson(invoiceItem)).toList(),
    );
  }
}
