import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final VoidCallback onPressed;
  final Color color;
  const CustomTextButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.onPressed,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800),
          ),
          const SizedBox(width: 12),
          Icon(
            icon,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
