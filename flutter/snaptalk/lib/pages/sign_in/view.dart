import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snaptalk/common/values/colors.dart';
import 'package:snaptalk/pages/sign_in/controller.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 100),
      width: 360.w,
      child: Text(
        'Snap Talk',
        style: GoogleFonts.aBeeZee()
            .copyWith(fontSize: 26.sp, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildThirdPartyLoginButton({required String title, required String provider}) {
    return GestureDetector(
      onTap: ()=> controller.handleSignIn(provider),
      child: Container(
        width: 250.w,
        height: 50.h,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
              child: Image.asset('assets/icons/$provider.png'),
            ),
            Container(
              child: Text(
                title,
                style: GoogleFonts.montserrat()
                    .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _buildLogo(),
        _buildThirdPartyLoginButton(title: 'Sign in with Google', provider: 'google'),
        _buildThirdPartyLoginButton(title: 'Sign in with Facebook', provider: 'facebook'),
        Container(
          child: Row(
            children: [
              Expanded(child: Divider(height: 2.h, endIndent: 20, indent: 10, color: AppColors.primarySecondaryElementText,)),
              Text(" or ", style: GoogleFonts.montserrat(),),
              Expanded(child: Divider(height: 2.h, indent: 20, endIndent: 10,  color: AppColors.primarySecondaryElementText,)),
            ],
          ),
        )
      ],
    ));
  }
}
