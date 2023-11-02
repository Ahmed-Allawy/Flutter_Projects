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
    return   Card(
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(60)),
                        color: Color.fromARGB(230, 170, 123, 60),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset(
                                deviceImagePath,
                                height: 70,
                                color: Colors.white,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      deviceName,
                                      style: GoogleFonts.oswald(
                                          fontSize: 18, color: Colors.white),
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
                      );
  }
}
