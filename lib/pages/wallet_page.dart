import 'dart:convert';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    futureInvoiceItems = fetchInvoices();
  }

  @override
  Widget build(BuildContext context) {
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
                      color: ColorConstants.kgreenColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
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
                        "11 June 2021",
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
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: FutureBuilder<Invoice>(
                      future: futureInvoiceItems,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Invoice currentInvoice = snapshot.data;
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 50, bottom: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: setActiveColor(currentInvoice)
                                  .withOpacity(0.1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LimitedBox(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          currentInvoice.invoiceItems.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.all(0),
                                      itemBuilder: (context, index) {
                                        InvoiceItem invoiceItem = currentInvoice
                                            .invoiceItems
                                            .elementAt(index);
                                        return InvoiceItemWidget(
                                          title: invoiceItem.name,
                                          description: invoiceItem.description,
                                        );
                                      }),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("Unable to load your wallet Transactions");
                        }
                        return Container(
                            // child: LinearProgressIndicator(),
                            );
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
                            child: Text(
                              "Kes 1500",
                              style: GoogleFonts.spartan(
                                fontSize: 18,
                                color: ColorConstants.kblackColor,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.right,
                            )),
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
                        style: TextButton.styleFrom(
                            backgroundColor: ColorConstants.kgreenColor),
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
    final response =
        await http.get(Uri.parse(ApiConstants.apiEndpoint + "invoice/one"));
    if (response.statusCode == 200) {
      return Invoice.fromJson(jsonDecode(response.body));
      /*setActiveColor(invoice);
      return invoice;*/
    } else {
      throw Exception('Unable to load your recent invoices');
    }
  }

  Color setActiveColor(Invoice invoice) {
    if (invoice.status != "unpaid") {
      activeColor = ColorConstants.kgreenColor;
    } else {
      activeColor = ColorConstants.kRedColor;
    }
    return activeColor;
  }
}
