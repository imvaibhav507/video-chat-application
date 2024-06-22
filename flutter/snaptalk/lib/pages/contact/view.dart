import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snaptalk/common/entities/contact.dart';
import 'package:snaptalk/common/values/colors.dart';
import 'package:snaptalk/pages/contact/controller.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget _buidAppbar() {
      return AppBar(
        title: Text(
          'Contact',
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
    }

    Widget _buildListItem(ContactItem contact) {
      
      return Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: AppColors.primarySecondaryBackground))),
        child: Row(
          children: [
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
                imageUrl: contact.avatar!,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress, strokeWidth: 1.5.h,),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fadeInDuration: const Duration(milliseconds: 500),
                fadeOutDuration: const Duration(milliseconds: 500),
                imageBuilder: (context, imageProvider) => Image(image: imageProvider)

                ),
              ),
            Container(
              padding: EdgeInsets.only(left: 10.w, top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 244.w, height: 40.h,
                    child: Text(
                        '${contact.name}',
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.montserrat().copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.thirdElement,
                        fontSize: 16.sp,
                      )
                    ),
                  ),
                  Container(
                    width: 12.w,
                    height: 12.w,
                    child: Image.asset('assets/icons/ang.png'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Obx(
        () => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buidAppbar(),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: controller.state.contactList.length,
                      (context, index) {
                var item = controller.state.contactList[index];
                return GestureDetector(
                  onTap: ()=> controller.goToChat(item),
                    child: _buildListItem(item));
              })),
            )
          ],
        ),
      ),
    );

    //   Scaffold(
    //   appBar: _buidAppbar(),
    //     body: SafeArea(
    //       child: Center(child: Text(controller.state.contactList.toList().toString()),),
    //     )
    // );
  }
}
