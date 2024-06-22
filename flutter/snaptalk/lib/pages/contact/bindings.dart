import 'package:get/get.dart';
import 'package:snaptalk/pages/contact/controller.dart';

class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(() => ContactController());
  }
}