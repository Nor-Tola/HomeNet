import 'package:flutter/material.dart';

Widget authTextField({
  required String hint,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  IconData? icon,
}) {
  return TextField(
    keyboardType: keyboardType,
    obscureText: obscureText,
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      hintText: hint,
      filled: true,
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
