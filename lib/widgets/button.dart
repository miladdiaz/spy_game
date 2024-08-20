import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final Color? color;

  const Button({
    super.key,
    required this.onPressed,
    required this.label,
    this.color = Colors.deepPurple,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
