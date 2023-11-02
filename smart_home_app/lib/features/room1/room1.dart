// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_home_app/core/utils/helperFunctions.dart';
import 'package:smart_home_app/features/home/home.dart';
import 'package:smart_home_app/features/livingRoom/cubit/room1_cubit.dart';

import '../../core/utils/assets.dart';

import '../../core/widgets/deviceBox.dart';
import '../../mqtt/topics.dart';
import '../livingRoom/cubit/room1_state.dart';

class Room1 extends StatefulWidget {
  const Room1({super.key});

  @override
  State<Room1> createState() => _Room1State();
}

class _Room1State extends State<Room1> {
  @override
  void initState() {
    ROOM1Cubit.get(context).subscribeToTopic(lump1Room1);
    ROOM1Cubit.get(context).subscribeToTopic(airConditionerRoom1);
    ROOM1Cubit.get(context).subscribeToTopic(tvRoom1);
    ROOM1Cubit.get(context).subscribeToTopic(fanRoom1);
    ROOM1Cubit.get(context).subscribeToTopic(humRoom1);
    ROOM1Cubit.get(context).subscribeToTopic(temRoom1);

    ///listen to broker
    ROOM1Cubit.get(context)
        .client
        .client!
        .updates!
        .listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      // final MqttPublishMessage recTopic = c[0].topic as MqttPublishMessage;
      ROOM1Cubit.get(context).listenToBroker(
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message),
          c[0].topic);

      // print('YOU GOT A NEW MESSAGE:');
      // print('alla data isssss : ${c[0].topic}');
      // print('message from callback');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: BackButton(onPressed: (){
            nextScreenRep(context, Home());
          },),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'living room',
            style: GoogleFonts.oswald(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<ROOM1Cubit, ROOM1State>(builder: (context, state) {
          return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.srgbToLinearGamma(),
                    image: AssetImage(Assets.livingRoomImage),
                    fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 30.0),
                  //   child: Row(
                  //     children: [
                  //       BackButton(
                  //         onPressed: (){
                  //            nextScreenRep(context, Home());
                  //         },
                  //       ),
                  //       Text(
                  //         'living room',
                  //         style: GoogleFonts.oswald(
                  //           fontSize: 30,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                                'Room Humidity',
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
                                '${ROOM1Cubit.get(context).temperature} C',
                                style: GoogleFonts.oswald(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${ROOM1Cubit.get(context).humidity} %',
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
                                itemCount:
                                    ROOM1Cubit.get(context).devices.length,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: DeviceBox(
                                        deviceImagePath: ROOM1Cubit.get(context)
                                            .devices[index][0],
                                        deviceName: ROOM1Cubit.get(context)
                                            .devices[index][1],
                                        deviceState: ROOM1Cubit.get(context)
                                            .devices[index][2],
                                        onChange: (value) {
                                          ROOM1Cubit.get(context).publishData(
                                              ROOM1Cubit.get(context)
                                                  .devices[index][3],
                                              value.toString());
                                          // ROOM1Cubit.get(context).deviceActivated();
                                        }),
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        })
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
