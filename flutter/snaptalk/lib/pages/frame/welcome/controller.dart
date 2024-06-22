import 'package:get/get.dart';
import 'package:snaptalk/common/routes/names.dart';
import 'package:snaptalk/pages/frame/welcome/state.dart';

class WelcomeController extends GetxController {

  WelcomeController();

  final title = "SnapTalk";
  final state = WelcomeState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    Future.delayed(Duration(seconds: 3), ()=> Get.offAllNamed(AppRoutes.Message));
  }
}