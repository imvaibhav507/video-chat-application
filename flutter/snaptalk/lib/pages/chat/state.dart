import 'package:get/get.dart';
import 'package:snaptalk/common/entities/entities.dart';

class ChatState {
 RxList<Msgcontent> msgContentList = <Msgcontent>[].obs;

 var to_token = ''.obs;
 var to_name = ''.obs;
 var to_avatar = ''.obs;
 var to_online = ''.obs;

 var open_menu = false.obs;
}