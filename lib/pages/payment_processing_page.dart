import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:paylink_app/shared/api_constants.dart';
import 'package:paylink_app/shared/color_constants.dart';

class PaymentProcessingPage extends StatefulWidget {
  const PaymentProcessingPage({Key key}) : super(key: key);

  @override
  _PaymentProcessingPageState createState() => _PaymentProcessingPageState();
}

class _PaymentProcessingPageState extends State<PaymentProcessingPage> {
  String _amount = "";
  Future<http.Response> futurePayment;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final amount = ModalRoute.of(context).settings.arguments as String;
    _amount = amount;
    futurePayment = makePayment();
    return Scaffold(
        backgroundColor: ColorConstants.kwhiteColor,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Image.asset('assets/images/card.png'),
                ),
              ),
              LimitedBox(
                child: FutureBuilder<http.Response>(
                  future: futurePayment,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text("Enter your pin to complete the transaction",
                          style: GoogleFonts.lato(
                              fontSize: 18, color: ColorConstants.kgreenColor));
                    } else if (snapshot.hasError) {
                      Text("Sorry, we are unable to process your transaction",
                          style: GoogleFonts.lato(
                              fontSize: 18, color: ColorConstants.kRedColor));
                      return new Container(
                        child: LinearProgressIndicator(),
                      );
                      // return new CustomErrorWidget();
                    }
                    // By default, show a loading spinner.
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 2,
                      child: Center(child: CircularProgressIndicator()),
                    );
                    // return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Future<http.Response> makePayment() async {
    final response = await http.post(
      Uri.parse(ApiConstants.mpesaEmdpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer FLWSECK-06573ecc063f2cb1ed69130ca8f1dbc1-X'
      },
      body: jsonEncode(<String, String>{
        "tx_ref": "MC-15852113s09v5050e8",
        "amount": _amount,
        "currency": "KES",
        "email": "user@flw.com",
        "phone_number": "254707076869",
        "fullname": "Michael Makali"
      }),
    );

    print(response.body.toString());

    return response;
  }
}
