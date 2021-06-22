import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paylink_app/shared/color_constants.dart';

class CardWidget extends StatelessWidget {
  CardWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: Container(
          // height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  ColorConstants.cblackColor,
                  ColorConstants.cgreenColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.centerRight,
              )),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.credit_card,
                      color: ColorConstants.kwhiteColor,
                    ),
                    onPressed: () {},
                    tooltip: 'KYC',
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 15, top: 25, bottom: 10, right: 20),
                    child: Text(
                      'NKR',
                      style: GoogleFonts.spartan(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.kwhiteColor,
                      ),
                    ),
                  ),
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
                      '4562 1122 4595 7852',
                      style: GoogleFonts.spartan(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.kwhiteColor,
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: 15,
                                top: 25,
                                bottom: 10,
                                right: 20,
                              ),
                              child: Text(
                                'CARD HOLDER',
                                style: GoogleFonts.spartan(
                                  fontSize: 7,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.kwhiteColor,
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
                                'Mike Makali',
                                style: GoogleFonts.spartan(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.kwhiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: 15,
                                top: 25,
                                bottom: 10,
                                right: 20,
                              ),
                              child: Text(
                                'Balance',
                                style: GoogleFonts.spartan(
                                  fontSize: 7,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.kwhiteColor,
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
                                'KES 3000',
                                style: GoogleFonts.spartan(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.kwhiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: 15,
                                top: 25,
                                bottom: 10,
                                right: 20,
                              ),
                              child: Text(
                                'Expiry Date',
                                style: GoogleFonts.spartan(
                                  fontSize: 7,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.kwhiteColor,
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
                                '07/2021',
                                style: GoogleFonts.spartan(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.kwhiteColor,
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
            ],
          ),
        ),
      );
  }
}
