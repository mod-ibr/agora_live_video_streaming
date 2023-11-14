import 'package:flutter/material.dart';

class ChannelNameTextField extends StatelessWidget {
  final TextEditingController channelNameController;
  const ChannelNameTextField({super.key, required this.channelNameController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: channelNameController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.teal),
          ),
          hintText: "Enter Channel Name..."),
    );
  }
}
