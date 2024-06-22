import 'package:get/get.dart';
import 'package:snaptalk/pages/sign_in/controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}