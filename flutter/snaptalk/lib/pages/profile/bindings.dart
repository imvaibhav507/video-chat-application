import 'package:get/get.dart';
import 'package:snaptalk/pages/profile/controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}