import 'package:flutter/material.dart';

class AddressTextfield extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Color borderColor;
  final TextEditingController? controller;

  const AddressTextfield({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    this.borderColor = Colors.deepOrange,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
