import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:paylink_app/models/license.dart';
import 'package:paylink_app/shared/api_constants.dart';
import 'package:paylink_app/shared/color_constants.dart';
import 'package:paylink_app/widgets/invoice_widget.dart';
import 'package:paylink_app/widgets/make_payment_widget.dart';
import 'package:paylink_app/widgets/select_qr_widget.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key key}) : super(key: key);

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  Future<List<License>> futureInvoice;

  @override
  void initState() {
    super.initState();
    futureInvoice = fetchInvoices();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "My Invoices",
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
                  height: 5,
                ),
                Text(
                  "Automatic Invoice payment",
                  style: GoogleFonts.spartan(
                    fontSize: 18,
                    color: ColorConstants.kblackColor,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SelectQRWidget(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Your Current Invoices",
                  style: GoogleFonts.spartan(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.kblackColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                LimitedBox(
                  child: FutureBuilder<List<License>>(
                    future: futureInvoice,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<License> licenses = snapshot.data ?? [];
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: licenses.length,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(0),
                            itemBuilder: (context, index) {
                              License license = licenses.elementAt(index);
                              return InvoiceWidget(
                                title: license.name,
                                description: license.description,
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error} yes yes");
                      }
                      // By default, show a loading spinner.
                      return Container();
                      // return CircularProgressIndicator();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<List<License>> fetchInvoices() async {
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
