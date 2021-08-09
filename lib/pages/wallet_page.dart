import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:paylink_app/models/invoice.dart';
import 'package:paylink_app/models/invoice_item.dart';
import 'package:paylink_app/shared/api_constants.dart';
import 'package:paylink_app/shared/color_constants.dart';
import 'package:paylink_app/widgets/invoice_item.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  Future<Invoice> futureInvoiceItems;
  Color activeColor;

  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    futureInvoiceItems = fetchInvoices();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String currentDate = date.toString().split(" ")[0];

    return Scaffold(
        body: Container(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 35,
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: ColorConstants.kgreenColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Card",
                            style: GoogleFonts.spartan(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.kwhiteColor,
                            ),
                          ),
                          Text(
                            "Card Transaction Statement",
                            style: GoogleFonts.spartan(
                              fontSize: 12,
                              color: ColorConstants.kwhiteColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        currentDate,
                        style: GoogleFonts.spartan(
                          fontSize: 12,
                          color: ColorConstants.kwhiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: FutureBuilder<Invoice>(
                      future: futureInvoiceItems,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Invoice currentInvoice = snapshot.data;
                          return Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: setActiveColor(currentInvoice).withOpacity(0.1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LimitedBox(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: currentInvoice.invoiceItems.length,
                                      physics: const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.all(0),
                                      itemBuilder: (context, index) {
                                        InvoiceItem invoiceItem = currentInvoice.invoiceItems.elementAt(index);
                                        return InvoiceItemWidget(
                                          title: invoiceItem.name,
                                          description: invoiceItem.description,
                                          paidAt: invoiceItem.paidAt,
                                        );
                                      }),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          // return Text("Unable to load your wallet Transactions");
                          return Text(snapshot.error.toString());
                        }
                        return Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Center(
                              child: LinearProgressIndicator(),
                            ));
                      }),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Current Balance",
                              style: GoogleFonts.spartan(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: ColorConstants.kblackColor,
                              ),
                              textAlign: TextAlign.right,
                            )),
                        SizedBox(
                          width: double.infinity,
                          child: FutureBuilder<Invoice>(
                              future: futureInvoiceItems,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Invoice currentInvoice = snapshot.data;
                                  return Text(
                                    'KES ' + currentInvoice.balance.toString(),
                                    style: GoogleFonts.spartan(
                                      fontSize: 18,
                                      color: ColorConstants.kblackColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.right,
                                  );
                                }
                                if (snapshot.hasError) {
                                  return Text(
                                    "Unavailable",
                                    style: GoogleFonts.spartan(
                                      fontSize: 18,
                                      color: ColorConstants.kRedColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.right,
                                  );
                                }
                                return Container();
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/top-up');
                        },
                        style: TextButton.styleFrom(backgroundColor: ColorConstants.kgreenColor),
                        child: Text(
                          "Top up Card",
                          style: GoogleFonts.spartan(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.kwhiteColor,
                          ),
                        )),
                  ),
                ),
              ],
            )));
  }

  Future<Invoice> fetchInvoices() async {
    var jwt = await storage.read(key: "token");
    final response = await http.get(Uri.parse(ApiConstants.apiEndpoint + "wallet/history"), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $jwt',
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      storage.write(key: 'token', value: response.headers['token']);
      return Invoice.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Unable to load your recent invoices');
    }
  }

  Color setActiveColor(Invoice invoice) {
    return ColorConstants.kgreenColor;
  }
}
