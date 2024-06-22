import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snaptalk/common/values/colors.dart';

class CustomPopupMenuButton extends StatelessWidget {
  CustomPopupMenuButton({super.key, required this.path, this.onTap});
  String path;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 40.w,
        width: 40.w,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.w),
            color: AppColors.primaryBackground,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(1, 1)
              )
            ]
        ),
        child: Image.asset(path),
      ),
      onTap: () => onTap?.call(),
    );
  }
}
