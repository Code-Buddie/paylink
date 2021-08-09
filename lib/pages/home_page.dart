import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:paylink_app/models/service.dart';
import 'package:paylink_app/shared/api_constants.dart';
import 'package:paylink_app/shared/color_constants.dart';
import 'package:paylink_app/widgets/card_widget.dart';
import 'package:paylink_app/widgets/select_qr_widget.dart';
import 'package:paylink_app/widgets/service_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Service>> futureServices;

  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    futureServices = fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String currentDate = date.toString().split(" ")[0];

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: ColorConstants.kwhiteColor,
                    ),
                    Icon(
                      Icons.more_vert,
                      color: ColorConstants.kwhiteColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  'Nakuru County Government',
                  style: GoogleFonts.spartan(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.kgreenColor,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Mike Makali',
                  style: GoogleFonts.spartan(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.kgreyColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 2,
              right: 2,
              top: 30,
            ),
            child: Container(
              // height: 200,
              child: CardWidget(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Automated payments",
                  style: GoogleFonts.spartan(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
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
                  "Make payments",
                  style: GoogleFonts.spartan(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.kblackColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ServiceWidget(
                  title: "Today's parking",
                ),
                ServiceWidget(
                  title: "Top up Wallet",
                  route: '/top-up',
                ),
                LimitedBox(
                  child: FutureBuilder<List<Service>>(
                    future: futureServices,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Service> services = snapshot.data ?? [];
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: services.length,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(0),
                            itemBuilder: (context, index) {
                              Service service = services.elementAt(index);
                              return ServiceWidget(
                                title: service.name,
                              );
                            });
                      } else if (snapshot.hasError) {
                        //_showAlert();
                        return new Container();
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

  Future<List<Service>> fetchServices() async {
    var jwt = await storage.read(key: "token");
    final response = await http.get(Uri.parse(ApiConstants.apiEndpoint + "services/all"), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $jwt',
    });
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson.body.toString());

      return (responseJson as List).map((license) => Service.fromJson(license)).toList();
    } else {
      throw Exception('Unable to load your recent payments');
    }
  }

  void _showErrorAlert() async {
    await Future.delayed(Duration(microseconds: 1));
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              title: Text("No internet"),
              content: Text("Are you offline? \nWe are unable to load your data"),
              actions: [
                TextButton(
                    style: TextButton.styleFrom(
                      primary: ColorConstants.kgreenColor,
                    ),
                    onPressed: null,
                    child: Text(
                      "Reload Data",
                      style: GoogleFonts.spartan(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.kgreenColor,
                      ),
                    )),
                TextButton(
                    style: TextButton.styleFrom(
                      primary: ColorConstants.kgreenColor,
                    ),
                    onPressed: null,
                    child: Text(
                      "Open Settings",
                      style: GoogleFonts.spartan(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.kgreyColor,
                      ),
                    )),
              ],
            ));
  }
}
