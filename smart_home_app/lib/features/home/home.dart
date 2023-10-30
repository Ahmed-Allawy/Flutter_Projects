import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_app/core/utils/helperFunctions.dart';
import 'package:smart_home_app/features/room1/room1.dart';

import '../../core/utils/assets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              image: DecorationImage(
                                  image: AssetImage(Assets.userImage),
                                  fit: BoxFit.fill
                                  // fit: BoxFit.cover,
                                  )),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome',
                            style: GoogleFonts.oswald(
                              fontSize: 13,
                              color: Color.fromARGB(255, 199, 195, 195),
                            ),
                          ),
                          Text(
                            'Ahmed Allawy',
                            style: GoogleFonts.oswald(
                              fontSize: 15,
                              color: Color.fromARGB(250, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Your Rooms',
                    style: GoogleFonts.oswald(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    children: [
                      InkWell(
                        onTap: () {
                          nextScreen(context, Room1());
                        },
                        child: RoomsBox(
                          roomImage: Assets.livingRoomImage,
                          roomName: 'Living Room',
                          numberOfDevices: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class RoomsBox extends StatelessWidget {
  RoomsBox({
    super.key,
    required this.roomImage,
    required this.roomName,
    required this.numberOfDevices,
  });
  final String roomImage;
  final String roomName;
  final int numberOfDevices;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                colorFilter: ColorFilter.srgbToLinearGamma(),
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
              Text('Living Room',
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
