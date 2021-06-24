import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paylink_app/shared/color_constants.dart';

class PaymentCompletePage extends StatefulWidget {
  const PaymentCompletePage({Key key}) : super(key: key);

  @override
  _PaymentCompletePageState createState() => _PaymentCompletePageState();
}

class _PaymentCompletePageState extends State<PaymentCompletePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                padding: EdgeInsets.all(56),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConstants.kwhiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.kgreenColor.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset('assets/images/confirm.png'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Payment Complete!',
                        style: GoogleFonts.spartan(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.kgreenColor,
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConstants.kwhiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Amount",
                          style: GoogleFonts.spartan(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.kblackColor,
                              height: 2),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "KES 220",
                              style: GoogleFonts.spartan(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstants.kgreenColor,
                                  height: 2),
                            ),
                            Text(
                              "30/06/2021",
                              style: GoogleFonts.spartan(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstants.kblackColor,
                                  height: 2),
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Parking Info",
                          style: GoogleFonts.spartan(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.kblackColor,
                              height: 2),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "KBX 242Q",
                              style: GoogleFonts.spartan(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstants.kgreenColor,
                                  height: 2),
                            ),
                            Text(
                              "Nakuru West",
                              style: GoogleFonts.spartan(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstants.kblackColor,
                                  height: 2),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConstants.kgreenColor,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.kgreenColor.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "MPESA",
                      style: GoogleFonts.spartan(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.kwhiteColor,
                      ),
                    ),
                    Text(
                      "OASASA23949L",
                      style: GoogleFonts.spartan(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.kwhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                  },
                  child: Icon(Icons.close, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    shadowColor: ColorConstants.kgreenColor.withOpacity(0.4),
                    padding: EdgeInsets.all(20),
                    primary: ColorConstants.kgreenColor,
                    onPrimary: ColorConstants.kRedColor,
                    elevation: 5,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
