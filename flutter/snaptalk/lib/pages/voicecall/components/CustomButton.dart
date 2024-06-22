import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, this.child, this.onTap, this.color});

  Widget? child;
  VoidCallback? onTap;
  Color? color;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      child: Container(
        height: 50.w,
        width: 50.w,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.w),
            color: color
        ),
        child: child,
      ),
      onTap: () => onTap?.call(),
    );
  }
}
