import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snaptalk/common/routes/names.dart';
import 'package:snaptalk/common/values/colors.dart';
import 'package:snaptalk/pages/chat/components/CustomPopupMenuButton.dart';
import 'package:snaptalk/pages/message/components/AvatarLogo.dart';
import 'package:snaptalk/pages/message/components/ContactButton.dart';
import 'controller.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        '${controller.state.to_name}',
        overflow: TextOverflow.clip,
        maxLines: 1,
        style: TextStyle(
          fontFamily: "montserrat",
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
      ),
      actions: [
        Container(
          width: 44.w,
          height: 44.w,
          margin: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: AppColors.primarySecondaryBackground,
            borderRadius: BorderRadius.circular(22.w),
          ),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
              imageUrl: controller.state.to_avatar.value,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                    value: downloadProgress.progress,
                    strokeWidth: 1.5.h,
                  ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fadeInDuration: const Duration(milliseconds: 500),
              fadeOutDuration: const Duration(milliseconds: 500),
              imageBuilder: (context, imageProvider) =>
                  Image(image: imageProvider)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: Obx(
            ()=> SafeArea(
              child: Stack(
            children: [
              Positioned(
                  bottom: 0.h,
                  child: Container(
                    width: 360.w,
                    padding: EdgeInsets.only(left: 12.w, bottom: 6.h),
                    child: Row(
                      children: [
                        Container(
                          width: 274.w,
                          padding:
                              EdgeInsets.only(top: 6.h, bottom: 6.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.w),
                              color: AppColors.primaryBackground,
                              border: Border.all(
                                  color: AppColors.primarySecondaryElementText)),
                          child: Row(
                            children: [
                              Container(
                                width: 220.w,
                                child: TextField(
                                  controller: controller.textController,
                                  keyboardType: TextInputType.multiline,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Message...",
                                      hintStyle: const TextStyle(
                                        color: AppColors.primarySecondaryElementText
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: 15.w, top: 0, bottom: 0)),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => controller.sendMessage(),
                                child: Container(
                                  width: 40.w,
                                  height: 40.w,
                                  child: Image.asset('assets/icons/send.png'),
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            height: 40.w,
                            width: 40.w,
                            margin: EdgeInsets.symmetric(horizontal: 14.w),
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: AppColors.primaryElement,
                              borderRadius: BorderRadius.circular(40.w)
                            ),
                            child: Image.asset('assets/icons/add.png'),
                          ),
                          onTap: () => controller.toggleMenu(),
                        )
                      ],
                    ),
                  )),
              (controller.state.open_menu.isTrue) ? Positioned(
                right: 20.w,
                bottom: 70.h,
                height: 230.h,
                width: 40.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   CustomPopupMenuButton(path: 'assets/icons/file.png'),
                   CustomPopupMenuButton(path: 'assets/icons/photo.png'),
                   CustomPopupMenuButton(path: 'assets/icons/call.png',
                     onTap: ()=> controller.gotoVoiceCall(),),
                   CustomPopupMenuButton(path: 'assets/icons/video.png'),
                  ],
                ),
              ): Container()
            ],
          )),
        ));
  }
}
