import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:paylink_app/shared/color_constants.dart';

class TransactionListWidget extends StatelessWidget {
  final String description, paidOn, area;
  final int amount;

  TransactionListWidget({
    Key key,
    @required this.description,
    @required this.paidOn,
    @required this.amount,
    @required this.area,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberFormat = new NumberFormat("##.00###", "en_US");
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorConstants.kwhiteColor,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.kgreyColor.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(2, 3), // changes position of shadow
          ),
        ],
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
                    formatDate(),
                    style: GoogleFonts.openSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.kgreyColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    description,
                    style: GoogleFonts.openSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.kblackColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    area,
                    style: GoogleFonts.openSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.kblackColor,
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
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Text(
              r'KES ' + "${numberFormat.format(amount)}",
              style: GoogleFonts.openSans(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: ColorConstants.kgreenColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}
