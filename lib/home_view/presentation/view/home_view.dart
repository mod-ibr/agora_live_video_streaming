import 'package:agora_live_video_streaming/home_view/presentation/view/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'broadcast_view.dart';
import 'widgets/channel_name_text_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _channelNameController = TextEditingController();
  String check = '';

  @override
  void dispose() {
    super.dispose();
    _channelNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Agora Live Video Streaming"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.85,
              height: MediaQuery.sizeOf(context).height * 0.2,
              child: ChannelNameTextField(
                  channelNameController: _channelNameController),
            ),
            CustomTextButton(
                label: "Join",
                icon: Icons.remove_red_eye,
                onPressed: () => onJoin(isBroadCaster: false),
                color: Colors.teal),
            CustomTextButton(
                label: "Broadcast",
                icon: Icons.broadcast_on_home_rounded,
                onPressed: () => onJoin(isBroadCaster: true),
                color: Colors.amber),
            Text(
              check,
              style: const TextStyle(fontSize: 20, color: Colors.brown),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onJoin({required bool isBroadCaster}) async {
    //* Request Permissions
    await [Permission.camera, Permission.microphone].request().then(
          (value) => //* Navigate to BroadCast View
              Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BroadCastView(
                  broadcastName: _channelNameController.text,
                  isBroadcaster: isBroadCaster),
            ),
          ),
        );
  }
}
