
import 'package:flutter/material.dart';

class RoomsBox extends StatelessWidget {
  RoomsBox({
    super.key,
    required this.roomImage,
    required this.roomName,
    required this.numberOfDevices, required this.effect,
  });
  final String roomImage;
  final String roomName;
  final String numberOfDevices;
  final bool effect;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              
                colorFilter: effect? ColorFilter.srgbToLinearGamma(): null,
                
                image: AssetImage(roomImage),
                fit: BoxFit.fill)),
        child: Container(
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
             
                transform: GradientRotation((22 / 7) / 2),
                stops: [0.5, 0.9],
                colors: [const Color.fromARGB(0, 74, 30, 30), Colors.black]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(roomName,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              Text('Active devices: $numberOfDevices',
                  style: TextStyle(
                      fontSize: 13, color: Color.fromARGB(199, 255, 255, 255))),
            ],
          ),
        ),
      ),
    );
  }
}
