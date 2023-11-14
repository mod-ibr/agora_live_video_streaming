import 'package:flutter/material.dart';

/// Video view row wrapper
class ExpandedVideoView extends StatelessWidget {
  final List<Widget> views;

  const ExpandedVideoView({super.key, required this.views});

  @override
  Widget build(BuildContext context) {
    final wrappedViews = views
        .map<Widget>((view) => Expanded(child: Container(child: view)))
        .toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }
}
