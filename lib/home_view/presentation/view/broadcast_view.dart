import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import '../../../core/constants/app_constants.dart';

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
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
