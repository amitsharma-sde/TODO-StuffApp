import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_stuff/utils/constant.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.btnColor,
      this.textColor});
  final String text;
  final VoidCallback onPressed;
  final Color? btnColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 1.sw,
        height: 36.h,
        decoration: BoxDecoration(
            color: btnColor ?? kPurpleDeep,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: kPurpleDeep, width: 2)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? kWhite,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
