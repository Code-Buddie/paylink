import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:paylink_app/models/parking_info.dart';
import 'package:paylink_app/shared/api_constants.dart';
import 'package:paylink_app/shared/color_constants.dart';
import 'package:paylink_app/widgets/transaction_list_widget.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({Key key}) : super(key: key);

  @override
  _PaymentHistoryPageState createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  Future<List<ParkingInfo>> futureParkingInfo;

  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    futureParkingInfo = fetchLicense();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.kwhiteColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Payments history",
                          style: GoogleFonts.spartan(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.kblackColor,
                          ),
                        ),
                        TextButton(
                            onPressed: null,
                            child: Icon(
                              Icons.search,
                              color: ColorConstants.kblackColor,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: double.infinity,
                        // height: double.infinity,
                        child: FutureBuilder<List<ParkingInfo>>(
                          future: futureParkingInfo,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<ParkingInfo> payments = snapshot.data ?? [];
                              if (payments.isEmpty) {
                                return Text("You haven't made any payments yet");
                              } else {
                                return ListView.builder(
                                    itemCount: payments.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.all(0),
                                    itemBuilder: (context, index) {
                                      ParkingInfo payment = payments[index];
                                      return new TransactionListWidget(description: payment.carPlates, paidOn: payment.area, area: payment.area, amount: 200);
                                    });
                              }
                            } else if (snapshot.hasError) {
                              return Text("Unable to fetch your payment history!");
                            }
                            // By default, show a loading spinner.
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        )),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget searchWidget() {
    return Container(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.search), Text("Search")],
          ),
        ),
      ),
    );
  }

  Future<List<ParkingInfo>> fetchLicense() async {
    var jwt = await storage.read(key: "token");
    final response = await http.get(Uri.parse(ApiConstants.apiEndpoint + "payment/history"), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $jwt',
    });
    if (response.statusCode == 200) {
      storage.write(key: 'token', value: response.headers['token']);
      var responseJson = json.decode(response.body);
      print(responseJson);
      return (responseJson as List).map((parkingInfo) => ParkingInfo.fromJson(parkingInfo)).toList();
    } else {
      throw Exception('Unable to load your recent payments');
    }
  }
}
