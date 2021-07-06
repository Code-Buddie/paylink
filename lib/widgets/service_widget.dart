import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paylink_app/shared/color_constants.dart';

class ServiceWidget extends StatelessWidget {
  final String title;
  final String route;

  const ServiceWidget({
    @required this.title,
    this.route = '/park-payment',
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Column(
          children: [
            Container(
              // height: 80,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConstants.kwhiteColor,
                  border: Border.all(color: ColorConstants.kblackColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        /*height: 50,
                        width: 50,*/
                        decoration: BoxDecoration(
                          color: ColorConstants.kwhiteColor,
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Center(
                          child: Icon(Icons.credit_card),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          LimitedBox(
                            child: Text(
                              title,
                              style: GoogleFonts.spartan(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: ColorConstants.kblackColor,
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
                      color: ColorConstants.kblackColor,
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
        ));
  }
}
