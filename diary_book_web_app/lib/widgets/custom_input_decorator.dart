import 'package:flutter/material.dart';

InputDecoration customInputDecoration(String lable, String hint) {
  return InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Color(0xFF69639F), width: 1.5)),
      labelText: lable,
      hintText: hint);
}
