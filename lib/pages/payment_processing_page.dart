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
    // final amount = "200";
    _amount = amount;
    futurePayment = makePayment();
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: ColorConstants.kwhiteColor,
            body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/payments.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Wrap(children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width / 1.01,
                              padding: EdgeInsets.all(20),
                              // height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                color: ColorConstants.kwhiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorConstants.kgreyColor
                                        .withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    // offset: Offset(3, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Card Top up",
                                          style: GoogleFonts.lato(
                                              fontSize: 26,
                                              color:
                                                  ColorConstants.kgreenColor)),
                                      Text("KES $amount",
                                          style: GoogleFonts.lato(
                                              fontSize: 26,
                                              color:
                                                  ColorConstants.kgreenColor)),
                                    ],
                                  ),
                                  Divider(),
                                  Text(
                                      "You should receive confirmation from M‑Pesa on +254 707 076869 in less than a minute.",
                                      style: GoogleFonts.lato(
                                          fontSize: 18,
                                          color: ColorConstants.kblackColor)),
                                  Divider(),
                                  LimitedBox(
                                    child: FutureBuilder<http.Response>(
                                      future: futurePayment,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                              "Please enter your pin to complete the transaction",
                                              style: GoogleFonts.lato(
                                                  fontSize: 18,
                                                  color: ColorConstants
                                                      .kgreenColor));
                                        } else if (snapshot.hasError) {
                                          Text(
                                              "Sorry, we are unable to process your transaction",
                                              style: GoogleFonts.lato(
                                                  fontSize: 18,
                                                  color: ColorConstants
                                                      .kRedColor));
                                          return Container(
                                            child: LinearProgressIndicator(),
                                          );
                                          // return new CustomErrorWidget();
                                        }
                                        // By default, show a loading spinner.
                                        return Container(
                                          child: LinearProgressIndicator(),
                                        );
                                        // return CircularProgressIndicator();
                                      },
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 20),
                                      width: double.infinity,
                                      // height: 50,
                                      padding: EdgeInsets.all(18),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: ColorConstants.kRedColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "Cancel",
                                        style: GoogleFonts.spartan(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: ColorConstants.kwhiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ]))))));
  }

  Future<http.Response> makePayment() async {
    final response = await http.post(
      Uri.parse(ApiConstants.mpesaEndpoint),
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
