import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:snaptalk/common/routes/names.dart';
import 'package:snaptalk/common/values/colors.dart';

class AvatarLogo extends StatelessWidget {
  AvatarLogo({super.key, this.path});

  String? path;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 44.h,
      margin: EdgeInsets.only(bottom: 20.h, top: 20.h),
      child: Row(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: ()=>Get.toNamed(AppRoutes.Profile),
                child: Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                      color: AppColors.primarySecondaryBackground,
                      borderRadius: BorderRadius.circular(22.h),
                      boxShadow:  [
                        BoxShadow(
                            color:  Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1)

                        )
                      ]
                  ),
                  child:  path == null ?
                  Image(image: AssetImage("assets/images/account_header.png")):
                  Text('hi'),
                ),
              ),
              Positioned(
                  top: 24.h,
                  left: 32.h,
                  child:
                  Container(
                    width: 15.w,
                    height: 15.h,
                    decoration: BoxDecoration(
                        color: AppColors.primaryElementStatus,
                        border: Border.all(
                            width: 2.w,
                            color: AppColors.primaryElementText
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(16.h))
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
