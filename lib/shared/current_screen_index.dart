import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paylink_app/pages/home_page.dart';
import 'package:paylink_app/pages/invioce_page.dart';
import 'package:paylink_app/pages/payment_history_page.dart';
import 'package:paylink_app/pages/wallet_page.dart';

class CurrentScreenIndex extends StatelessWidget {
  final int index;

  CurrentScreenIndex(
      this.index,
      );

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        {
          return HomePage();
        }
        break;
      case 1:
        {
          return PaymentHistoryPage();
        }
        break;
      case 2:
        {
          return WalletPage();
        }
        break;
      default:
        {
          return HomePage();
        }
        break;
    }
  }
}
