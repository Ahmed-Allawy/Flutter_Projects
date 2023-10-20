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
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  borderRadius: BorderRadius.circular(40),
                  // focusColor: const Color.fromARGB(255, 155, 13, 13),
                  // hoverColor: Colors.black,
                  onTap: () {},
                  child: Image.asset(
                    Assets.menuImage,
                    height: 45,
                  ),
                ),
                InkWell(
                    borderRadius: BorderRadius.circular(40),
                    onTap: () {},
                    child: const Icon(Icons.person, size: 45))
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Welcome back to home!'),
                  Text(
                    'Ahmed Allawy',
                    style: GoogleFonts.oswald(
                        fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Room Temperature',
                        style: GoogleFonts.oswald(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Room Homidity',
                        style: GoogleFonts.oswald(fontSize: 20),
                      ),
                    ],
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
                          ),
                        ),
                        Text(
                          '25 %',
                          style: GoogleFonts.oswald(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Active devices',
                    style: GoogleFonts.oswald(
                      fontSize: 25,
                    ),
                  ),
                ],
              )),
          // ActiveDevices(),
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

class ActiveDevices extends StatelessWidget {
  const ActiveDevices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 150,
              ),
              child: DeviceBox(
                deviceImagePath: Assets.lumpImage,
                deviceName: 'Lump 1',
                deviceState: false,
                onChange: (value) {
                  print(value);
                },
              ),
            );
          }),
    );
  }
}


// class Room1 extends StatelessWidget {
//   const Room1({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//                       ROOM1Cubit.get(context)
//                           .publishData(lump1Room1, 'From new Architecture');
//                     },
//                     child: const Text('publish message'),
//                   ),
//                   const SizedBox(height: 50),
//                   Text('lump is: ${ROOM1Cubit.get(context).lump1State}')
//                 ]),
//           );
//         },
//       ),
//     );
//   }
// }
