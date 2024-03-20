import 'package:flutter/material.dart';

InputDecoration customInputDecoration(String label, String hint) {
  return InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1.5, color: Colors.blue)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(width: 1.5, color: Colors.deepPurple)),
      hintText: hint,
      labelText: label);
}
