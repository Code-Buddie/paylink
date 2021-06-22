import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:paylink_app/models/license.dart';
import 'package:paylink_app/shared/api_constants.dart';
import 'package:paylink_app/shared/color_constants.dart';
import 'package:paylink_app/widgets/make_payment_widget.dart';

class SelectPaymentPage extends StatefulWidget {
  const SelectPaymentPage({Key key}) : super(key: key);

  @override
  _SelectPaymentPageState createState() => _SelectPaymentPageState();
}

class _SelectPaymentPageState extends State<SelectPaymentPage> {
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
                  children: [
                    searchWidget(),
                    Text(
                      "Make payments",
                      style: GoogleFonts.spartan(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.kblackColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FutureBuilder<List<License>>(
                      future: futureLicense,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<License> licenses = snapshot.data ?? [];
                          return ListView.builder(
                              itemCount: licenses.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                License license = licenses[index];
                                return new MakePaymentWidget(
                                  title: license.name,
                                  description: "Parking fees",
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        // By default, show a loading spinner.
                        return CircularProgressIndicator();
                      },
                    ),
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
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
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
            children: [Icon(Icons.search), Text("Searc")],
          ),
        ),
      ),
    );
  }

  Future<List<License>> fetchLicense() async {
    final response = await http
        .get(Uri.parse(ApiConstants.apiEndpoint));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return (responseJson as List)
          .map((license) => License.fromJson(license))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
