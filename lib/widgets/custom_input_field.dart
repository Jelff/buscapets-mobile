import 'package:flutter/material.dart';

Widget buildInputField({
  required String labelText,
  required TextEditingController controller,
  bool isPassword = false,
  TextInputType keyboardType = TextInputType.text,
  String? Function(String?)? validator,
  int? maxLength,
}) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword,
    keyboardType: keyboardType,
    maxLength: maxLength,
    decoration: InputDecoration(
      labelText: labelText,
      filled: true,
      fillColor: Color(0xFFECEFF5),
      contentPadding: const EdgeInsets.all(20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60),
        borderSide: BorderSide.none,
      ),
    ),
    validator: validator,
  );
}
