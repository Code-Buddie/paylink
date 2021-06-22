import 'package:flutter/material.dart';
import 'package:paylink_app/pages/auth/forgot_password_page.dart';
import 'package:paylink_app/pages/auth/login_page.dart';
import 'package:paylink_app/pages/auth/signup_page.dart';
import 'package:paylink_app/pages/index.dart';
import 'package:paylink_app/pages/invioce_details_page.dart';
import 'package:paylink_app/pages/make_payment_page.dart';
import 'package:paylink_app/pages/parking_payment_page.dart';
import 'package:paylink_app/pages/payment_history_page.dart';
import 'package:paylink_app/pages/qr_scan_page.dart';
import 'package:paylink_app/pages/select_payment_page.dart';
import 'package:paylink_app/pages/splash_screen_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/park-payment',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => IndexPage(),
        '/start': (context) => SplashScreenPage(),
        '/login': (context) => LoginPage(),
        '/sign-up': (context) => SignUpPage(),
        '/forgot': (context) => ForgotPasswordPage(),
        '/payments': (context) => SelectPaymentPage(),
        '/qr-payment': (context) => QRScanPage(),
        '/history': (context) => PaymentHistoryPage(),
        '/invoice': (context) => InvoiceDetailsPage(),
        '/make-payment': (context) => MakePaymentPage(),
        '/park-payment': (context) => ParkingPaymentPage(),
      },
    );
  }
}

