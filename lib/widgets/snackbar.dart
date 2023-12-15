import 'package:flutter/material.dart';

class CustomSnackbar extends StatelessWidget {
  final String content;
  final Color backgroundColor;

  const CustomSnackbar({
    required this.content,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SnackBar(
          content: Text(
            content,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}
