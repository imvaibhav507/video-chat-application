import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:snaptalk/common/routes/names.dart';
import 'package:snaptalk/common/values/colors.dart';
import 'package:snaptalk/pages/message/components/AvatarLogo.dart';
import 'package:snaptalk/pages/message/components/ContactButton.dart';
import 'package:snaptalk/pages/message/controller.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  Widget _buildPageHeadTitle(String title) {
    return Container(
      margin: EdgeInsets.only(top: 350),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.primarySecondaryElementText,
          fontFamily: "montserrat",
          fontWeight: FontWeight.bold,
          fontSize: 45.sp,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAppBar() {
    return Center(
      child: AvatarLogo(
        path: controller.state.head_detail.value.avatar,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              title: _buildAppBar(),
            )
          ],
        ),
        Positioned(
            height: 50.w,
            width: 50.w,
            right: 20.w,
            bottom: 70.w,
            child: ContactButton(
              onTap: () => Get.toNamed(AppRoutes.Contact),
            ))
      ],
    )));
  }
}
