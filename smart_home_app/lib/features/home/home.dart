import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_home_app/core/utils/helperFunctions.dart';
import 'package:smart_home_app/features/home/cubit/home_cubit.dart';
import 'package:smart_home_app/features/home/cubit/home_state.dart';
import 'package:smart_home_app/features/room1/room1.dart';

import '../../core/utils/assets.dart';
import '../../core/widgets/roomsBox.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    HOMECUBIT
        .get(context)
        .client
        .client!
        .updates!
        .listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      HOMECUBIT.get(context).getActiveDevice(
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message),
          c[0].topic);
    });
    super.initState();
  }

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
                BlocBuilder<HOMECUBIT, HOMESTATE>(
                  builder: (context, state) {
                    return Expanded(
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
                              numberOfDevices:
                                  HOMECUBIT.get(context).numberOfActiveDevices,
                              effect: true,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // nextScreen(context, Room1());
                            },
                            child: RoomsBox(
                              roomImage: Assets.kitchenImage,
                              roomName: 'Kitchen Room',
                              numberOfDevices: 3,
                              effect: false,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // nextScreen(context, Room1());
                            },
                            child: RoomsBox(
                              roomImage: Assets.bedImage,
                              roomName: 'Bed Room',
                              numberOfDevices: 1,
                              effect: false,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // nextScreen(context, Room1());
                            },
                            child: RoomsBox(
                              roomImage: Assets.bathImage,
                              roomName: 'Bath Room',
                              numberOfDevices: 0,
                              effect: true,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }
}
