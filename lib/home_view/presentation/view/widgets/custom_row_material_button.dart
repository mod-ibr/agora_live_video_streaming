import 'package:flutter/material.dart';

class CustomRowMaterialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color fillColor;
  final IconData iconData;
  final Color iconColor;
  final double iconSize;

  const CustomRowMaterialButton({
    super.key,
    required this.onPressed,
    required this.fillColor,
    required this.iconData,
    required this.iconColor,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      elevation: 2.0,
      fillColor: fillColor,
      padding: const EdgeInsets.all(12.0),
      child: Icon(
        iconData,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
