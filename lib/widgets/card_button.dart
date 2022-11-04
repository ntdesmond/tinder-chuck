import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  const CardButton({
    super.key,
    required this.onPressed,
    required this.buttonColor,
    required this.buttonContentColor,
    required this.icon,
  });

  final VoidCallback onPressed;
  final Color buttonColor;
  final Color buttonContentColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Ink(
        decoration: ShapeDecoration(
          color: buttonColor,
          shape: const CircleBorder(),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: buttonContentColor),
        ),
      );
}
