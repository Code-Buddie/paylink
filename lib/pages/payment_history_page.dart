import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:paylink_app/models/license.dart';
import 'package:paylink_app/shared/api_constants.dart';
import 'package:paylink_app/shared/color_constants.dart';
import 'package:paylink_app/widgets/transaction_list_widget.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({Key key}) : super(key: key);

  @override
  _PaymentHistoryPageState createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  Future<List<License>> futureLicense;

  @override
  void initState() {
    super.initState();
    futureLicense = fetchLicense();
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
                        child: FutureBuilder<List<License>>(
                      future: futureLicense,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<License> licenses = snapshot.data ?? [];
                          return ListView.builder(
                              itemCount: licenses.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.all(0),
                              itemBuilder: (context, index) {
                                License license = licenses[index];
                                return new TransactionListWidget(
                                        description: license.name,
                                        paidOn: "Parking fees",
                                        amount: 5000);
                              });
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        // By default, show a loading spinner.
                        return CircularProgressIndicator();
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

  Future<List<License>> fetchLicense() async {
    final response =
        await http.get(Uri.parse(ApiConstants.apiEndpoint + "license/test"));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return (responseJson as List)
          .map((license) => License.fromJson(license))
          .toList();
    } else {
      throw Exception('Unable to load your recent payments');
    }
  }
}
