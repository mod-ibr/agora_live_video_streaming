import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_constants.dart';
import 'widgets/ToolBar.dart';
import 'widgets/custom_broadcast_view.dart';

class BroadCastView extends StatefulWidget {
  final String broadcastName;
  final bool isBroadcaster;
  const BroadCastView(
      {super.key, required this.broadcastName, required this.isBroadcaster});

  @override
  State<BroadCastView> createState() => _BroadCastViewState();
}

class _BroadCastViewState extends State<BroadCastView> {
  final List<int> _users = [];
  late RtcEngine _engine;
  bool muted = false;
  int? streamId;
  bool _localUserJoined = false;
  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    //* Clear All Users
    _users.clear();
    //* Destroy SDK and leave the Channel
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  void initState() {
    super.initState();
    //* Initialize Agora SDK
    initializeAgora();
  }

  Future<void> initializeAgora() async {
    //* initialize Agora RTC Engine
    await initAgoraRtcEngine();
    if (widget.isBroadcaster) {
      streamId = await _engine.createDataStream(
          const DataStreamConfig(ordered: false, syncWithAudio: false));
    }
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          log("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          log("local user ${connection.localUid} Leaved");
          setState(() {
            log('onLeaveChannel');
            _users.clear();
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          log("remote user $remoteUid joined");
          setState(() {
            log('userJoined: $remoteUid');

            _users.add(remoteUid);
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          log("remote user $remoteUid left channel");
          setState(() {
            log('userOffline: $remoteUid');
            _users.remove(remoteUid);
          });
        },
        onStreamMessage: (RtcConnection connection, int remoteUid, int streamId,
            Uint8List data, int length, int sentTs) {
          String message = utf8.decode(data);
          final String info = "here is the message $message";
          log(info);
        },
        onStreamMessageError: (RtcConnection connection, int remoteUid,
            int streamId, ErrorCodeType code, int missed, int cached) {
          final String info = "here is the error $code";
          log(info);
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          log('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );
    await _engine.joinChannel(
      token: AppConstants.token,
      channelId: AppConstants.channelId,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> initAgoraRtcEngine() async {
    //* Create  the Engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: AppConstants.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    //* Define the User Role
    if (widget.isBroadcaster) {
      await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    } else {
      await _engine.setClientRole(role: ClientRoleType.clientRoleAudience);
    }

    await _engine.enableVideo();
    await _engine.startPreview();
  }

  //* Helper function to get list of native views
  List<Widget> getRenderViews() {
    final List<Widget> list = [];
    if (widget.isBroadcaster) {
      list.add(localeView());
    }
    for (int? uid in _users) {
      if (uid != null) {
        list.add(remoteView(uid: uid));
      }
    }
    return list;
  }

  Widget localeView() {
    return _localUserJoined
        ? AgoraVideoView(
            controller: VideoViewController(
              rtcEngine: _engine,
              canvas: const VideoCanvas(uid: 0),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }

  Widget remoteView({required int uid}) {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: _engine,
        canvas: VideoCanvas(uid: uid),
        connection: const RtcConnection(channelId: AppConstants.channelId),
      ),
    );
  }

  void _onCallEnd() {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    //! Uncomment when you want to send an Message Via the Stream Connection
    /*
    String messageData = "mute user blet";
    // Convert String to List<int> using UTF-8 encoding
    List<int> utf8Bytes = utf8.encode(messageData);

    // Convert List<int> to Uint8List
    Uint8List uint8List = Uint8List.fromList(utf8Bytes);

    if (streamId != null) {
      _engine.sendStreamMessage(
          data: uint8List, length: uint8List.length, streamId: streamId!);
    }
     */
    _engine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            CustomBroadcastView(views: getRenderViews()),
            ToolBar(
              isBroadcaster: widget.isBroadcaster,
              muted: muted,
              onCallEnd: _onCallEnd,
              onSwitchCamera: () => _onSwitchCamera(),
              onToggleMute: _onToggleMute,
            ),
          ],
        ),
      ),
    );
  }
}
