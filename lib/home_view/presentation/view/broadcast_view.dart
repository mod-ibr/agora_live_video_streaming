import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
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
  }

  Future<void> initAgoraRtcEngine() async {}

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Stack(
          children: [
            CustomBroadcastView(),
            ToolBar(),
          ],
        ),
      ),
    );
  }
}
