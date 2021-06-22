import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paylink_app/shared/color_constants.dart';

class InvoiceItemWidget extends StatelessWidget {
  final String title, description;

  InvoiceItemWidget({
    Key key,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Text(description)
            ],
          ),
          Text("Kes 200000"),
        ],
      ),
    );
  }
}
