import 'package:flutter/material.dart';

import 'custom_row_material_button.dart';

class ToolBar extends StatelessWidget {
  final bool isBroadcaster, muted;
  final VoidCallback onToggleMute, onCallEnd, onSwitchCamera;

  const ToolBar(
      {super.key,
      required this.isBroadcaster,
      required this.onToggleMute,
      required this.muted,
      required this.onCallEnd,
      required this.onSwitchCamera});

  @override
  Widget build(BuildContext context) {
    return isBroadcaster
        ? Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomRowMaterialButton(
                  onPressed: () => onToggleMute(),
                  fillColor: muted ? Colors.blueAccent : Colors.white,
                  iconData: muted ? Icons.mic_off : Icons.mic,
                  iconColor: muted ? Colors.white : Colors.blueAccent,
                  iconSize: 20.0,
                ),
                CustomRowMaterialButton(
                  onPressed: () => onCallEnd(),
                  fillColor: Colors.redAccent,
                  iconData: Icons.call_end,
                  iconColor: Colors.white,
                  iconSize: 35.0,
                ),
                CustomRowMaterialButton(
                  onPressed: onSwitchCamera,
                  fillColor: Colors.white,
                  iconData: Icons.switch_camera,
                  iconColor: Colors.blueAccent,
                  iconSize: 20.0,
                ),
              ],
            ),
          )
        : Container();
  }
}
