import 'package:get/get.dart';
import 'package:snaptalk/pages/chat/controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}