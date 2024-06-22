import 'package:get/get.dart';
import 'package:snaptalk/pages/frame/welcome/controller.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeController>(() => WelcomeController());
  }
}