import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snaptalk/common/apis/apis.dart';
import 'package:snaptalk/common/entities/entities.dart';
import 'package:snaptalk/common/routes/names.dart';
import 'package:snaptalk/common/store/store.dart';
import 'package:snaptalk/common/widgets/toast.dart';

class SignInController extends GetxController {
  SignInController();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['openid']);

  Future<void> handleSignIn(String type) async {
    try {
      if (type == "google") {
        var user = await _googleSignIn.signIn();
        if (user != null) {
          LoginRequestEntity requestEntity = LoginRequestEntity(
            type: 1,
            name: user.displayName,
            email: user.email,
            avatar: user.photoUrl ?? 'assets/icons/google.png',
            open_id: user.id,
          );
          if (kDebugMode) {
            print(jsonEncode(requestEntity));
          }
          asyncPostAllData(requestEntity);
        }
      } else {
        if (kDebugMode) {
          print("login  type not specified...");
        }
      }
    } catch (error) {
      print("error while logging in: $error");
    }
  }

  asyncPostAllData(LoginRequestEntity requestEntity) async {

    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear, dismissOnTap: true
    );
   var result = await UserAPI.Login(params: requestEntity);
   if(result.code==0) {
     await UserStore.to.saveProfile(result.data!);
     EasyLoading.dismiss();
   }
   else {
     EasyLoading.dismiss();
     toastInfo(msg: "No internet available");
   }
    Get.offAllNamed(AppRoutes.Message);
  }
}
