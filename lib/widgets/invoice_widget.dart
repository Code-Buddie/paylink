import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paylink_app/shared/color_constants.dart';

class InvoiceWidget extends StatelessWidget {
  final String title, description;

  InvoiceWidget({
    Key key,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/invoice');
        },
        child: Column(
          children: [
            Container(
              // height: 80,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConstants.kwhiteColor,
                  // border: Border.all(color: ColorConstants.kblackColor)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            title,
                            style: GoogleFonts.spartan(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.kblackColor,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Payment of ' + description,
                            style: GoogleFonts.spartan(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.kgreyColor,
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
              height: 15,
            )
          ],
        ));
  }
}
