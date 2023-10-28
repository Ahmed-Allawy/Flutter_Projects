// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_home_app/features/room1/cobit/room1_cobit.dart';
import 'package:smart_home_app/mqtt/topics.dart';

import '../../core/utils/assets.dart';

import '../../core/widgets/deviceBox.dart';

class Room1 extends StatefulWidget {
  const Room1({super.key});

  @override
  State<Room1> createState() => _Room1State();
}

class _Room1State extends State<Room1> {
  @override
  void initState() {
    // subscribe to topics
    ROOM1Cubit.get(context).subscribeToTopic(lump1Room1);

    ///listen to broker
    ROOM1Cubit.get(context)
        .client
        .client!
        .updates!
        .listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;

      ROOM1Cubit.get(context).listenToBroker(
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message));

      // print('YOU GOT A NEW MESSAGE:');
      // print('alla data isssss : ${c[0].topic}');
      print('message from callback');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.livingRoomImage), fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  'living room',
                  style: GoogleFonts.oswald(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40)),
                    color: Color.fromARGB(197, 59, 47, 19)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Room Temperature',
                            style: GoogleFonts.oswald(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Room Homidity',
                            style: GoogleFonts.oswald(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '36 C',
                            style: GoogleFonts.oswald(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '25 %',
                            style: GoogleFonts.oswald(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Text(
                        'Room devices',
                        style: GoogleFonts.oswald(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: SizedBox(
                        height: 140,
                        width: double.infinity,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 16,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: DeviceBox(
                                    deviceImagePath: Assets.lumpImage,
                                    deviceName: 'Lump 1',
                                    deviceState: true,
                                    onChange: (value) {}),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("HIVEMQ broker (Smart Home)"),
//         backgroundColor: const Color.fromARGB(255, 248, 175, 5),
//       ),
//       body: BlocBuilder<ROOM1Cubit, ROOM1State>(
//         builder: (context, state) {
//           return Center(
//             // child: Text(msg),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   ElevatedButton(
//                     style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStateProperty.resolveWith<Color?>(
//                         (Set<MaterialState> states) {
//                           if (states.contains(MaterialState.pressed)) {
//                             return Theme.of(context)
//                                 .colorScheme
//                                 .primary
//                                 .withOpacity(0.5);
//                           }
//                           return null; // Use the component's default.
//                         },
//                       ),
//                     ),
//                     onPressed: () {
//                       ROOM1Cubit.get(context).publishData(
//                           lump1Room1, ROOM1Cubit.get(context).count.toString());
//                     },
//                     child: const Text('publish message'),
//                   ),
//                   const SizedBox(height: 50),
//                   Text('message is: ${ROOM1Cubit.get(context).lump1State}')
//                 ]),
//           );
//         },
//       ),
    );
  }
}
