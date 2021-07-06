import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paylink_app/shared/color_constants.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  const TitleText(
      {Key key,
        this.text,
        this.fontSize = 24,
        this.color = ColorConstants.kgreyColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.lato(
            fontSize: fontSize, fontWeight: FontWeight.w800, color: color));
  }
}