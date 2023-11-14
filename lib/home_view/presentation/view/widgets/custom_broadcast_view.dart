import 'package:flutter/material.dart';

import 'expanded_video_view.dart';

/// Video layout wrapper
class CustomBroadcastView extends StatelessWidget {
  final List<Widget> views;
  const CustomBroadcastView({super.key, required this.views});

  @override
  Widget build(BuildContext context) {
    switch (views.length) {
      case 1:
        return Column(
          children: <Widget>[
            ExpandedVideoView(views: [views[0]])
          ],
        );
      case 2:
        return Column(
          children: <Widget>[
            ExpandedVideoView(views: [views[0]]),
            ExpandedVideoView(views: [views[1]])
          ],
        );
      case 3:
        return Column(
          children: <Widget>[
            ExpandedVideoView(views: views.sublist(0, 2)),
            ExpandedVideoView(views: views.sublist(2, 3))
          ],
        );
      case 4:
        return Column(
          children: <Widget>[
            ExpandedVideoView(views: views.sublist(0, 2)),
            ExpandedVideoView(views: views.sublist(2, 4))
          ],
        );
      default:
    }
    return Container();
  }
}
