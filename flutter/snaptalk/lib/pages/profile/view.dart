import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:snaptalk/common/values/colors.dart';
import 'package:snaptalk/pages/profile/controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  PreferredSizeWidget _buildAppbar() {
    return AppBar(
      title: Text(
        "Profile",
        style: TextStyle(color: AppColors.primaryText, fontSize: 16.sp),
      ),
    );
  }

  Widget _buildPageHeadTitle(String title) {
    return Container(
      margin: EdgeInsets.only(top: 350),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: "montserrat",
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildLogo() {
    return Stack(
      children: [
        Container(
          width: 120.h,
          height: 120.h,
          decoration: BoxDecoration(
              color: AppColors.primarySecondaryBackground,
              borderRadius: BorderRadius.circular(120.w),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1))
              ]),
          child: Image(
              image: AssetImage("assets/images/account_header.png"),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            top: 80.h,
            left: 80.w,
            child: GestureDetector(
              child: Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                    color: AppColors.primaryElement,
                    borderRadius: BorderRadius.all(Radius.circular(40.w))),
                child: Image.asset("assets/icons/edit.png"),
              ),
            ))
      ],
    );
  }

  Widget _buildLogoutButton() {
    return GestureDetector(
      child: Container(
        width: 270.w,
        height: 44.h,
        decoration: BoxDecoration(
          color: AppColors.primarySecondaryBackground,
          borderRadius: BorderRadius.circular(12.h)
        ),
        child: Center(
          child: Text('Logout'),
        ),
      ),
      onTap: ()=> Get.defaultDialog(
        backgroundColor: AppColors.primarySecondaryBackground,
        title: "Are you sure you want to logout?",
        content: Container(),
        textCancel: "Cancel",
        textConfirm: "Confirm",
        confirmTextColor: Colors.white,
        onConfirm: () {
          controller.logout();
        },
        onCancel: () {}
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppbar(),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [_buildLogo(),
                    SizedBox(height: 200.h,),
                    _buildLogoutButton()
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
