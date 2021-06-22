import 'package:barcode_widget/barcode_widget.dart';
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
              Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Select Payment Method",
                      style: GoogleFonts.spartan(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.kblackColor,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right: 5),
                              child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: _flag
                                        ? ColorConstants.kgreenColor
                                        : ColorConstants.kgreyColor,
                                  ),
                                  onPressed: () =>
                                      setState(() => _flag = !_flag),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _flag ? Icon(Icons.check) : Container(),
                                      Text(
                                        "M-pesa",
                                        style: GoogleFonts.spartan(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: ColorConstants.kwhiteColor,
                                        ),
                                      )
                                    ],
                                  ))),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left: 5),
                              child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: _flag
                                        ? ColorConstants.kgreyColor
                                        : ColorConstants.kgreenColor,
                                  ),
                                  onPressed: () =>
                                      setState(() => _flag = !_flag),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _flag ? Container() : Icon(Icons.check),
                                      Text(
                                        "Bank Payment",
                                        style: GoogleFonts.spartan(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: ColorConstants.kwhiteColor,
                                        ),
                                      )
                                    ],
                                  ))),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: null,
                      style: TextButton.styleFrom(
                          backgroundColor: ColorConstants.kgreenColor),
                      child: Text(
                        "Pay KES " + parkingInfo.amount,
                        style: GoogleFonts.spartan(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.kwhiteColor,
                        ),
                      )),
                ),
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
