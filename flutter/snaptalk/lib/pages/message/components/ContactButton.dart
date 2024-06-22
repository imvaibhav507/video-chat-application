import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snaptalk/common/values/colors.dart';

class ContactButton extends StatelessWidget {
  ContactButton({super.key, this.onTap});

  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50.w,
        width: 50.w,
        padding: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
            color: AppColors.primaryElement,
            borderRadius: BorderRadius.circular(40.w),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(1, 1))
            ]),
        child: Image.asset('assets/icons/contact.png'),
      ),
      onTap: () {
        onTap?.call();
      },
    );
  }
}
