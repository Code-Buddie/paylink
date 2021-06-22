import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paylink_app/shared/color_constants.dart';

class CustomErrorWidget extends StatelessWidget {
  CustomErrorWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(30),
            child: Text(
              "Oh..uh, we are having trouble",
              style: GoogleFonts.spartan(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: ColorConstants.kgreyColor,
              ),
            ),
          ),
          Image.asset('assets/images/offline.png'),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Are you offline? \nWe are unable to load your data",
              style: GoogleFonts.spartan(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: ColorConstants.kgreyColor,
              ),
              textAlign: TextAlign.center,
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
                          backgroundColor: ColorConstants.kgreenColor,
                        ),
                        onPressed: null,
                        child: Text(
                          "Reload Data",
                          style: GoogleFonts.spartan(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.kwhiteColor,
                          ),
                        ))),
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: ColorConstants.kgreyColor,
                        ),
                        onPressed: null,
                        child: Text(
                          "Open Settings",
                          style: GoogleFonts.spartan(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.kwhiteColor,
                          ),
                        ))),
              ),
            ],
          )
        ],
      ),
    );
  }
}
