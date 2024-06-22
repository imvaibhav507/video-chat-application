import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snaptalk/common/values/colors.dart';
import 'package:snaptalk/pages/voicecall/components/CustomButton.dart';
import 'controller.dart';

class VoiceCallPage extends GetView<VoiceCallController> {
  const VoiceCallPage({super.key});

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
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
        backgroundColor: AppColors.primary_bg,
        body: Obx(
          () => SafeArea(
            child: Stack(
              children: [
                Positioned(
                    top: 20.h,
                    left: 40.w,
                    right: 40.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            '${controller.state.callTime.value}',
                            style: GoogleFonts.montserrat().copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryBackground),
                          ),
                        ),
                        Container(
                          width: 100.w,
                          margin: EdgeInsets.only(top: 60.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.w),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child:
                              Image.network(controller.state.to_avatar.value),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Text(
                            controller.state.to_name.value,
                            style: GoogleFonts.montserrat().copyWith(
                                color: AppColors.primaryElementText,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )),
                Positioned(
                    bottom: 80.h,
                    left: 52.w,
                    width: 250.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          color: (controller.state.isMuted.isFalse)
                              ? AppColors.primaryElementText
                              : AppColors.primaryText,
                          child: (controller.state.isMuted.isFalse)
                              ? Image.asset('assets/icons/b_microphone.png')
                              : Image.asset('assets/icons/a_microphone.png'),
                          onTap: () => controller.toggleMicrophone(),
                        ),
                        CustomButton(
                          color: (controller.state.isJoined.isTrue)
                              ? AppColors.primaryElementBg
                              : AppColors.primaryElementStatus,
                          child: (controller.state.isJoined.isTrue)
                              ? Image.asset('assets/icons/a_phone.png')
                              : Image.asset('assets/icons/a_telephone.png'),
                          onTap: () => (controller.state.isJoined.isFalse)? controller.joinChannel():controller.leaveChannel() ,
                        ),
                        CustomButton(
                          color: (controller.state.enableSpeaker.isTrue)
                              ? AppColors.primaryElementText
                              : AppColors.primaryText,
                          child: (controller.state.enableSpeaker.isTrue)
                              ? Image.asset('assets/icons/b_trumpet.png')
                              : Image.asset('assets/icons/a_trumpet.png'),
                          onTap: () => controller.toggleSpeaker(),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
