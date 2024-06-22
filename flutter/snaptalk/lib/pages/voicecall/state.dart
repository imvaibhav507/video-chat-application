import 'package:get/get.dart';

class VoiceCallState {

  RxBool isJoined = false.obs;
  RxBool isMuted = false.obs;
  RxBool enableSpeaker = false.obs;
  RxString callTime = '00:00'.obs;
  RxString callStatus = 'Calling'.obs;

  var to_token = ''.obs;
  var to_name = ''.obs;
  var to_avatar = ''.obs;
  var call_role = 'audience'.obs;
  var channel_id = ''.obs;
  var doc_id = ''.obs;
}