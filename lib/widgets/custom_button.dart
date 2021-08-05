import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String title;
  final Function onPressed;

  CustomButton(
      {@required this.color,
        @required this.textColor,
        @required this.title,
        this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.0.h),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        child: MaterialButton(
          // padding: EdgeInsets.all(1.0.w),
          onPressed: onPressed,
          minWidth: double.infinity,
          height: 6.0.h,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: TextStyle(
                  color: textColor,
                  fontSize: SizerUtil.deviceType == DeviceType.tablet
                      ? 14.0.sp
                      : 16.0.sp),
            ),
          ),
        ),
      ),
    );
  }
}