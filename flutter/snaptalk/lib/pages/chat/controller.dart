import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:snaptalk/common/entities/entities.dart';
import 'package:snaptalk/common/routes/names.dart';
import 'package:snaptalk/common/store/store.dart';
import 'package:snaptalk/pages/chat/index.dart';
class ChatController extends GetxController {

  ChatController();

  final textController = TextEditingController();
  final state = ChatState();
  final db = FirebaseFirestore.instance;

  late String docId;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.parameters;
    docId = data['doc_id']!;
    state.to_token.value = data['to_token'] ?? '';
    state.to_avatar.value = data['to_avatar'] ?? '';
    state.to_name.value = data['to_name'] ?? '';
    state.to_online.value = data['to_online'] ?? '1';
    print('docId...$docId');
  }

 toggleMenu() {
    state.open_menu.value = !state.open_menu.value;
  }

  void gotoVoiceCall() {
    state.open_menu.value = false;
    Get.toNamed(AppRoutes.VoiceCall, parameters: {
      'to_token': state.to_token.value,
      'to_name': state.to_name.value,
      'to_avatar': state.to_avatar.value,
      'call_role': 'anchor',
      'doc_id':docId
    });
  }

  void sendMessage() async{
    final text = textController.value.text;

    textController.clear();

    if(text == null || text.isEmpty) {
      return;
    }

    final msg = Msgcontent(
      token: UserStore.to.profile.token,
      content: text,
      type: 'text',
      addtime: Timestamp.now()
    );

    await db.collection('messages').doc(docId).collection('msglist')
    .withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msg, options)=> msg.toFirestore())
    .add(msg).then((DocumentReference doc) {
      print('new message doc id... ${doc.id}');
    });
  }


}