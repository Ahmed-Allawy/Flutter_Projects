import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/assets.dart';

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
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: const Color.fromARGB(255, 45, 44, 44)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.asset(
              deviceImagePath,
              height: 80,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      deviceName,
                      style:
                          GoogleFonts.oswald(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  Switch(
                      activeColor: Colors.green,
                      value: deviceState,
                      onChanged: onChange)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
