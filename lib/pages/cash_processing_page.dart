import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:paylink_app/shared/api_constants.dart';
import 'package:paylink_app/shared/color_constants.dart';

class CashProcessingPage extends StatefulWidget {
  const CashProcessingPage({Key key}) : super(key: key);

  @override
  _CashProcessingPageState createState() => _CashProcessingPageState();
}

class _CashProcessingPageState extends State<CashProcessingPage> {
  Future<http.Response> futurePayment;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    futurePayment = makePayment();
    return Scaffold(
        backgroundColor: ColorConstants.kwhiteColor,
        body: Center(
            child: Wrap(
          children: [
            Container(
                margin: EdgeInsets.all(50),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConstants.kwhiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.kgreenColor.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(3, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Image.asset('assets/images/payment.png'),
                      ),
                    ),
                    Text(
                        "Nakuru County Government",
                        style: GoogleFonts.lato(
                            fontSize: 24, color: ColorConstants.kgreenColor)),
                    Divider(),
                    Text(
                        "Cash Payment",
                        style: GoogleFonts.lato(
                            fontSize: 22, color: ColorConstants.kgreyColor)),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween                      ,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                            "Area",
                            style: GoogleFonts.lato(
                                fontSize: 18, color: ColorConstants.kgreyColor)),
                        Text(
                            "Njoro",
                            style: GoogleFonts.lato(
                                fontSize: 18, color: ColorConstants.kgreyColor)),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween                      ,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                            "Car",
                            style: GoogleFonts.lato(
                                fontSize: 18, color: ColorConstants.kgreyColor)),
                        Text(
                            "KBX 242Q",
                            style: GoogleFonts.lato(
                                fontSize: 18, color: ColorConstants.kgreyColor)),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween                      ,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                            "Amount",
                            style: GoogleFonts.lato(
                                fontSize: 18, color: ColorConstants.kgreyColor)),
                        Text(
                            "Kes 200",
                            style: GoogleFonts.lato(
                                fontSize: 18, color: ColorConstants.kgreyColor)),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween                      ,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                            "Date",
                            style: GoogleFonts.lato(
                                fontSize: 18, color: ColorConstants.kgreyColor)),
                        Text(
                            "21/7/2021",
                            style: GoogleFonts.lato(
                                fontSize: 18, color: ColorConstants.kgreyColor)),
                      ],
                    ),
                    Divider(),
                    Divider(),
                    Text(
                        "Please wait as the parking attendant processes your payment",
                        style: GoogleFonts.lato(
                            fontSize: 18, color: ColorConstants.kgreyColor)),
                    LimitedBox(
                      child: FutureBuilder<http.Response>(
                        future: futurePayment,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Center(child: LinearProgressIndicator()),
                            );
                            // return Padding(
                            //   padding: EdgeInsets.only(
                            //       left: 15, right: 15, bottom: 15),
                            //   child: SizedBox(
                            //     width: double.infinity,
                            //     child: ElevatedButton(
                            //         onPressed: () {
                            //           Navigator.of(context)
                            //               .pushNamedAndRemoveUntil('/',
                            //                   (Route<dynamic> route) => false);
                            //         },
                            //         style: TextButton.styleFrom(
                            //             backgroundColor:
                            //                 ColorConstants.kgreenColor),
                            //         child: Text(
                            //           "Complete Payment",
                            //           style: GoogleFonts.spartan(
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.w700,
                            //             color: ColorConstants.kwhiteColor,
                            //           ),
                            //         )),
                            //   ),
                            // );
                          } else if (snapshot.hasError) {
                            Text(
                                "Sorry, we are unable to process your transaction",
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: ColorConstants.kRedColor));
                            return new Container(
                              child: LinearProgressIndicator(),
                            );
                            // return new CustomErrorWidget();
                          }
                          // By default, show a loading spinner.
                          return Container(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Center(child: LinearProgressIndicator()),
                          );
                          // return CircularProgressIndicator();
                        },
                      ),
                    ),
                  ],
                ))
          ],
        )));
  }

  Future<http.Response> makePayment() async {
    final response = await http.get(
      Uri.parse(ApiConstants.jsonEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 120));

    print(response.body.toString());

    return response;
  }
}
