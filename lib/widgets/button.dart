import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final VoidCallback onPressed; // Callback for onPressed
  final Widget child; // Child widget

  const Button({Key? key, required this.onPressed, required this.child})
      : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.deepOrange,
        side: BorderSide(width: 3, color: Colors.deepOrange),
      ),
      onPressed: widget.onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: widget.child,
      ),
    );
  }
}
