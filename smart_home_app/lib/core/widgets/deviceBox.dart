// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeviceBox extends StatelessWidget {
  const DeviceBox({
    super.key,
    required this.deviceImagePath,
    required this.deviceName,
    required this.deviceState,
    required this.onChange,
  });
  final String deviceImagePath;
  final String deviceName;
  final bool deviceState;
  final Function(bool?) onChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        width: 150,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
                deviceImagePath,
                height: 80,
                color: Colors.black,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      deviceName,
                      style:
                          GoogleFonts.oswald(fontSize: 25, color: Colors.black),
                    ),
                  ),
                  Transform.rotate(
                      angle: -pi / 2,
                      child: Switch(
                          activeColor: Colors.green,
                          value: deviceState,
                          onChanged: onChange))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
