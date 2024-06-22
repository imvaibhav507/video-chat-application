import 'package:get/get.dart';
import 'package:snaptalk/pages/voicecall/controller.dart';

class VoiceCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoiceCallController>(() => VoiceCallController());
  }
}