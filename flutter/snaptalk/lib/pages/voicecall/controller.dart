import 'dart:convert';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snaptalk/common/apis/apis.dart';
import 'package:snaptalk/common/entities/chat.dart';
import 'package:snaptalk/common/store/store.dart';
import 'package:snaptalk/common/values/server.dart';
import 'package:snaptalk/pages/voicecall/index.dart';

class VoiceCallController extends GetxController {

  VoiceCallController();

  final state = VoiceCallState();
  final player = AudioPlayer();
  String appId = APPID;
  final db = FirebaseFirestore.instance;
  final profile_token = UserStore.to.token;
  late final RtcEngine engine;

  @override
  void dispose() async {
    super.dispose();
    await player.pause();
    await engine.leaveChannel();
    await engine.release();
    await player.pause();
  }

  @override
  void onInit() {

    super.onInit();
    var data = Get.parameters;
    state.doc_id.value = data['doc_id']!;
    state.to_token.value = data['to_token'] ?? '';
    state.to_name.value = data['to_name'] ?? '';
    state.to_avatar.value = data['to_avatar'] ?? '';
    state.call_role.value = data['call_role'] ?? '';

    initEngine();
  }

  Future<void> initEngine() async {

    await player.setSource(AssetSource('Sound_Horizon.mp3'));
    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(
      appId: appId
    ));

    engine.registerEventHandler(RtcEngineEventHandler(
      onError: (err, msg) {
        print('error: $err   msg: $msg');
      },
      onJoinChannelSuccess: (connection, elapsed) {
        print('onConnection ${connection.toJson()}');
        state.isJoined.value = true;
    },
      onUserJoined: (connection, remoteUid, elapsed) async {
        await player.pause();
      },
      onLeaveChannel: (connection, stats) {
        print('my stats ${stats.toJson()}');
        state.isJoined.value = false;
    },
      onRtcStats: (connection, stats) {
        print('time... ${stats.duration}');
      }
    ));

    await engine.enableAudio();
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.setAudioProfile(
        profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming
    );

    await joinChannel();
    if(state.call_role.value == 'anchor') {
      //send notification to other user
      await sendNotification("voice");
      await player.resume();
    }
  }

  Future<void> sendNotification(String call_type) async {
    CallRequestEntity requestEntity = CallRequestEntity(
      call_type: call_type,
      to_token: state.to_token.value,
      to_avatar: state.to_avatar.value,
      to_name: state.to_name.value,
      doc_id: state.doc_id.value,
    );

    var res = await ChatAPI.call_notifications(params: requestEntity);
    if(res.code == 0) {
      print('notification sent..');
    }else {
      print('could not send notification..');
    }
  }

  Future<String> getRtcToken() async {
    if(state.call_role.value == 'anchor') {
      state.channel_id.value = md5
          .convert(utf8.encode('${profile_token}_${state.to_token}'))
          .toString();
    } else {
      state.channel_id.value = md5
          .convert(utf8.encode('${state.to_token}_$profile_token'))
          .toString();
    }

    final requestEntity = CallTokenRequestEntity(channel_name: state.channel_id.value);
    var res = await ChatAPI.call_token(params: requestEntity);
    if(res.code == 0) {
      return res.data!;
    }
    return '';
  }

  Future<void> joinChannel() async {
    await Permission.microphone.request();
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true
    );

    String rtcToken = await getRtcToken();
    if(rtcToken.isEmpty) {
      EasyLoading.dismiss();
      Get.back();
      return;
    }

    await engine.joinChannel(
        token: rtcToken,
        channelId: state.channel_id.value,
        uid: 0,
        options: const ChannelMediaOptions(
          channelProfile: ChannelProfileType.channelProfileCommunication,
          clientRoleType: ClientRoleType.clientRoleBroadcaster
        ));

    EasyLoading.dismiss();

  }

  void leaveChannel() async{
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true
    );

    await player.pause();
    state.isJoined.value = false;
    EasyLoading.dismiss();
    dispose();
    Get.back();
  }

  void toggleMicrophone() {
    state.isMuted.value = !state.isMuted.value;
  }
  void toggleCall() {
    state.isJoined.value = !state.isJoined.value;
  }
  void toggleSpeaker() {
    state.enableSpeaker.value = !state.enableSpeaker.value;
  }

}