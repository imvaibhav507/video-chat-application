import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:snaptalk/common/apis/apis.dart';
import 'package:snaptalk/common/entities/entities.dart';
import 'package:snaptalk/common/routes/names.dart';
import 'package:snaptalk/common/store/store.dart';
import 'package:snaptalk/pages/contact/index.dart';

class ContactController extends GetxController {
  ContactController();

  final state = ContactState();
  final token = UserStore.to.profile.token;
  final db = FirebaseFirestore.instance;

  @override
  Future<void> onReady() async {
    // TODO: implement onReady
    super.onReady();
    asyncAllData();
  }

  void goToChat(ContactItem item) async {
    var from_msgs = await db
        .collection("messages")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_token", isEqualTo: token)
        .where("to_token", isEqualTo: item.token)
        .get();

    var to_msgs = await db
        .collection("messages")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_token", isEqualTo: item.token)
        .where("to_token", isEqualTo: token)
        .get();

    if (from_msgs.docs.isEmpty && to_msgs.docs.isEmpty) {
      var profile = UserStore.to.profile;
      var newMsg = Msg(
        from_token: profile.token,
        from_avatar: profile.avatar,
        from_name: profile.name,
        from_online: profile.online,
        to_token: item.token,
        to_avatar: item.avatar,
        to_name: item.name,
        to_online: item.online,
        last_msg: "",
        last_time: Timestamp.now(),
        msg_num: 0,
      );

      var docId = await db
          .collection('messages')
          .withConverter(
              fromFirestore: Msg.fromFirestore,
              toFirestore: (msg, option) => msg.toFirestore())
          .add(newMsg);

      print(docId);
      Get.toNamed(AppRoutes.Chat, parameters: {
        "doc_id":docId.id,
        "to_token": item.token ?? '',
        "to_name": item.name ?? '',
        "to_avatar": item.avatar ?? '',
        "to_online": item.online.toString()
      });

      print("creating new user.... adding new doc");
    }
    else {
      var doc = await db
          .collection('messages')
          .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (msg, option) => msg.toFirestore());
      print(doc.id);
      Get.toNamed(AppRoutes.Chat, parameters: {
        "doc_id":doc.id,
        "to_token": item.token ?? '',
        "to_name": item.name ?? '',
        "to_avatar": item.avatar ?? '',
        "to_online": item.online.toString()
      });
      print("exiting chat present...");
    }
  }

  asyncAllData() async {
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );

    state.contactList.clear();
    var result = await ContactAPI.post_contact();
    if (kDebugMode) {
      print(jsonEncode(result.data));
    }

    if (result.code == 0) {
      state.contactList.addAll(result.data!);
    }
    EasyLoading.dismiss();
  }
}
