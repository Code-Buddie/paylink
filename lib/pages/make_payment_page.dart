import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paylink_app/models/parking_info.dart';
import 'package:paylink_app/shared/color_constants.dart';

class MakePaymentPage extends StatefulWidget {
  const MakePaymentPage({Key key}) : super(key: key);

  @override
  _MakePaymentPageState createState() => _MakePaymentPageState();
}

class _MakePaymentPageState extends State<MakePaymentPage> {
  bool _flag = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final parkingInfo =
        ModalRoute.of(context).settings.arguments as ParkingInfo;
    return Scaffold(
        backgroundColor: ColorConstants.kwhiteColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 60,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pay Parking fees",
                      style: GoogleFonts.spartan(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.kblackColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1),
                            color:
                                ColorConstants.kgreenColor.withOpacity(0.13)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.car_repair,
                                    color: ColorConstants.kgreyColor,
                                  ),
                                  onPressed: () {},
                                  tooltip: 'KYC',
                                ),
                                Container(
                                    padding: EdgeInsets.only(
                                        left: 15,
                                        top: 25,
                                        bottom: 10,
                                        right: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Nakuru County Government',
                                          style: GoogleFonts.spartan(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstants.kgreyColor,
                                          ),
                                        ),
                                        Text(
                                          'Parking',
                                          style: GoogleFonts.spartan(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstants.kgreyColor,
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 15,
                                    top: 30,
                                    bottom: 15,
                                  ),
                                  child: Text(
                                    parkingInfo.carPlates,
                                    style: GoogleFonts.spartan(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.kblackColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              top: 25,
                                              bottom: 10,
                                              right: 20,
                                            ),
                                            child: Text(
                                              'AREA',
                                              style: GoogleFonts.spartan(
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    ColorConstants.kblackColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              top: 0,
                                              bottom: 10,
                                              right: 20,
                                            ),
                                            child: Text(
                                              parkingInfo.area.toUpperCase(),
                                              style: GoogleFonts.spartan(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    ColorConstants.kblackColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              top: 25,
                                              bottom: 10,
                                              right: 20,
                                            ),
                                            child: Text(
                                              'Fee',
                                              style: GoogleFonts.spartan(
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    ColorConstants.kblackColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              top: 0,
                                              bottom: 10,
                                              right: 20,
                                            ),
                                            child: Text(
                                              'KES ' + parkingInfo.amount,
                                              style: GoogleFonts.spartan(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    ColorConstants.kblackColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              top: 25,
                                              bottom: 10,
                                              right: 20,
                                            ),
                                            child: Text(
                                              'Processing fee',
                                              style: GoogleFonts.spartan(
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    ColorConstants.kblackColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              top: 0,
                                              bottom: 10,
                                              right: 20,
                                            ),
                                            child: Text(
                                              'KES 20',
                                              style: GoogleFonts.spartan(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    ColorConstants.kblackColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              top: 25,
                                              bottom: 10,
                                              right: 20,
                                            ),
                                            child: Text(
                                              'Total',
                                              style: GoogleFonts.spartan(
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    ColorConstants.kblackColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              top: 0,
                                              bottom: 10,
                                              right: 20,
                                            ),
                                            child: Text(
                                              'KES ' + (parkingInfo.amount),
                                              style: GoogleFonts.spartan(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    ColorConstants.kblackColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: BarcodeWidget(
                                barcode: Barcode.gs128(useCode128B: true),
                                height: 50,
                                data: generateHash('Hello Flutter'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/complete', (Route<dynamic> route) => false);
                    },
                    child: Column(
                      children: [
                        Container(
                          // height: 80,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.kwhiteColor,
                              border: Border.all(
                                  color: ColorConstants.kgreenColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorConstants.kwhiteColor,
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.credit_card,
                                        color: ColorConstants.kgreenColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      LimitedBox(
                                        child: Text(
                                          "Pay KES " +
                                              parkingInfo.amount +
                                              " using my current number",
                                          style: GoogleFonts.spartan(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstants.kgreenColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: ColorConstants.kgreenColor,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        )
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: GestureDetector(
                    onTap: () {
                      // Save to firebase for test
                      DateTime now = new DateTime.now();
                      DateTime date =
                          new DateTime(now.year, now.month, now.day);
                      String currentDate = date.toString().split(" ")[0];
                      FirebaseFirestore.instance
                          .collection('payments')
                          .doc('KBX 242Q')
                          .collection(currentDate)
                          .add({
                            'amount': 300,
                            'area': "Nakuru",
                          })
                          .then((value) => Navigator.of(context)
                              .pushNamedAndRemoveUntil(
                                  '/complete', (Route<dynamic> route) => false))
                          .catchError((error) =>
                              print("Failed to make payment: $error"));
                    },
                    child: Column(
                      children: [
                        Container(
                          // height: 80,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.kwhiteColor,
                              border: Border.all(
                                  color: ColorConstants.kgreenColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorConstants.kwhiteColor,
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.credit_card,
                                        color: ColorConstants.kgreenColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      LimitedBox(
                                        child: Text(
                                          "Pay using other number",
                                          style: GoogleFonts.spartan(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstants.kgreenColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: ColorConstants.kgreenColor,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        )
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/process-cash');
                    },
                    child: Column(
                      children: [
                        Container(
                          // height: 80,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.kwhiteColor,
                              border: Border.all(
                                  color: ColorConstants.kgreenColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorConstants.kwhiteColor,
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.credit_card,
                                        color: ColorConstants.kgreenColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      LimitedBox(
                                        child: Text(
                                          "Pay Cash",
                                          style: GoogleFonts.spartan(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstants.kgreenColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: ColorConstants.kgreenColor,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        )
                      ],
                    )),
              ),
            ],
          ),
        ));
  }

  String generateHash(String s1) =>
      (<String>[s1, DateTime.now().toIso8601String()]..sort())
          .join()
          .hashCode
          .toString();
}
