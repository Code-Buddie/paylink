import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:paylink_app/pages/take_picture_screen.dart';
import 'package:paylink_app/shared/api_constants.dart';
import 'package:paylink_app/shared/color_constants.dart';

class CashProcessingPage extends StatefulWidget {
  const CashProcessingPage({Key key}) : super(key: key);

  @override
  _CashProcessingPageState createState() => _CashProcessingPageState();
}

class _CashProcessingPageState extends State<CashProcessingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String currentDate = date.toString().split(" ")[0];
    return Scaffold(
        backgroundColor: ColorConstants.kwhiteColor,
        body: Container(
            margin: EdgeInsets.only(top: 40, left: 5, right: 5),
            padding: EdgeInsets.all(15),
            child: Wrap(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                      child: Text("Nakuru County Government",
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: ColorConstants.kgreenColor)),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                      child: Text("By Mike Makali",
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: ColorConstants.kgreyColor)),
                    ),
                  ],
                ),
                Container(
                    // margin: EdgeInsets.all(50),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.kwhiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.kgreyColor.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 0,
                          // offset: Offset(3, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Cash Payment",
                            style: GoogleFonts.lato(
                                fontSize: 22,
                                color: ColorConstants.kgreyColor)),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("Area",
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: ColorConstants.kgreyColor)),
                            Text("Njoro",
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: ColorConstants.kgreyColor)),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("Car",
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: ColorConstants.kgreyColor)),
                            Text("KBX 242Q",
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: ColorConstants.kgreyColor)),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("Amount",
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: ColorConstants.kgreyColor)),
                            Text("Kes 200",
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: ColorConstants.kgreyColor)),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("Date",
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: ColorConstants.kgreyColor)),
                            Text(currentDate,
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: ColorConstants.kgreyColor)),
                          ],
                        ),
                        Divider(),
                        Divider(),
                        LimitedBox(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('payments')
                                .doc('KBX 242Q')
                                .collection(currentDate)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData)
                                return paymentProcessingWidgets();
                              if (snapshot.hasError)
                                return paymentFailedWidgets();
                              if (snapshot.hasData)
                                return paymentCompleteWidgets();
                              return paymentProcessingWidgets();
                            },
                          ),
                        ),
                      ],
                    )),
              ],
            )));
  }

  Widget paymentProcessingWidgets() {
    return new Column(
      children: [
        Text("Please wait as the parking attendant processes your payment",
            style: GoogleFonts.lato(
                fontSize: 18, color: ColorConstants.kgreyColor)),
        Container(
          padding: EdgeInsets.only(top: 15, bottom: 15),
          width: MediaQuery.of(context).size.width / 1.2,
          child: Center(child: LinearProgressIndicator()),
        )
      ],
    );
  }

  Widget paymentCompleteWidgets() {
    return new Column(
      children: [
        SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () async {
            final cameras = await availableCameras();
            final firstCamera = cameras.first;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TakePictureScreen(camera: firstCamera)),
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: 20),
            // padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorConstants.kwhiteColor,
                border: Border.all(color: ColorConstants.kgreenColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LimitedBox(
                  child: Text(
                    "Receipt Photo",
                    style: GoogleFonts.spartan(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.kgreenColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: Icon(
                    Icons.camera,
                    color: ColorConstants.kgreenColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          },
          child: Container(
            margin: EdgeInsets.only(top: 20),
            width: double.infinity,
            // height: 50,
            padding: EdgeInsets.all(18),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorConstants.kgreenColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Complete Payment",
              style: GoogleFonts.spartan(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: ColorConstants.kwhiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget paymentFailedWidgets() {
    return new Column(
      children: [
        Text("Sorry, we are unable to process your transaction",
            style:
                GoogleFonts.lato(fontSize: 18, color: ColorConstants.kRedColor))
      ],
    );
  }
}
