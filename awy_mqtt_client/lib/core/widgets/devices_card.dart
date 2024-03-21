import 'package:flutter/material.dart';

class DevicesCard extends StatelessWidget {
  const DevicesCard({
    super.key,
    required this.deviceName,
    required this.deviceImage,
    required this.onChanged,
    required this.deviceState,
  });
  final String deviceName;
  final String deviceImage;
  final bool deviceState;
  final Function(bool?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15.0),
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: Colors.white,
      elevation: 20,
      child: Column(
        children: [
          Image.asset(
            deviceImage,
            color: Colors.white,
            width: 90,
            height: 90,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    deviceName,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Transform.rotate(
                  angle: (22 / 7) / 2,
                  child: Switch(
                    value: deviceState,
                    onChanged: onChanged,
                    activeColor: Colors.green,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
