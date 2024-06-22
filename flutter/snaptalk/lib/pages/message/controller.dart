import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:snaptalk/common/apis/apis.dart';
import 'package:snaptalk/common/entities/base.dart';
import 'package:snaptalk/common/routes/names.dart';
import 'package:snaptalk/pages/message/index.dart';
class MessageController extends GetxController {

  MessageController();

  final state = MessageState();

  void gotoProfile() {
    Get.toNamed(AppRoutes.Profile);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    firebaseMessageSetup();
  }

  firebaseMessageSetup() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print("my fcm token... $fcmToken");
    if(fcmToken != null) {
      BindFcmTokenRequestEntity requestEntity = BindFcmTokenRequestEntity(fcmtoken: fcmToken);
      await ChatAPI.bind_fcmtoken(params: requestEntity);
    }
  }

}