import 'package:flutter/material.dart';
import 'package:paylink_app/shared/color_constants.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool isObscured;

  CustomTextField({@required this.hint, this.isObscured = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.0.h),
      child: TextField(
        obscureText: isObscured,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.kgreenColor),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
