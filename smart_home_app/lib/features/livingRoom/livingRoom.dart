import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_home_app/core/widgets/deviceBox.dart';
import 'package:smart_home_app/core/widgets/temperatureShape.dart';

import '../../core/utils/assets.dart';
import '../../core/utils/helperFunctions.dart';
import '../../mqtt/topics.dart';
import '../home/home.dart';
import 'cubit/room1_cubit.dart';
import 'cubit/room1_state.dart';

class LivingRoom extends StatefulWidget {
  const LivingRoom({super.key});

  @override
  State<LivingRoom> createState() => _LivingRoomState();
}

class _LivingRoomState extends State<LivingRoom> {
//  void initState() {
//     ROOM1Cubit.get(context).subscribeToTopic(lump1Room1);
//     ROOM1Cubit.get(context).subscribeToTopic(airConditionerRoom1);
//     ROOM1Cubit.get(context).subscribeToTopic(tvRoom1);
//     ROOM1Cubit.get(context).subscribeToTopic(fanRoom1);
//     ROOM1Cubit.get(context).subscribeToTopic(humRoom1);
//     ROOM1Cubit.get(context).subscribeToTopic(temRoom1);

//     ///listen to broker
//     ROOM1Cubit.get(context)
//         .client
//         .client!
//         .updates!
//         .listen((List<MqttReceivedMessage<MqttMessage>> c) {
//       final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
//       // final MqttPublishMessage recTopic = c[0].topic as MqttPublishMessage;
//       ROOM1Cubit.get(context).listenToBroker(
//           MqttPublishPayload.bytesToStringAsString(recMess.payload.message),
//           c[0].topic);

//       // print('YOU GOT A NEW MESSAGE:');
//       // print('alla data isssss : ${c[0].topic}');
//       // print('message from callback');
//     });
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   leading: BackButton(
      //     onPressed: () {
      //       nextScreenRep(context, Home());
      //     },
      //   ),
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   title: Text(
      //     'living room',
      //     style: GoogleFonts.oswald(
      //       fontSize: 30,
      //       color: Colors.white,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body:Center(child: Text("data"),),
      // body: BlocBuilder<ROOM1Cubit, ROOM1State>(builder: (context, state) {
      //   return Container(
      //     decoration: BoxDecoration(
      //       image: DecorationImage(
      //           colorFilter: ColorFilter.srgbToLinearGamma(),
      //           image: AssetImage(Assets.livingRoomImage),
      //           fit: BoxFit.cover),
      //     ),
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(bottom: 30.0),
          //       child: Container(width: double.infinity, child: TempShape(tValue: ROOM1Cubit.get(context).temperature, hValue: ROOM1Cubit.get(context).humidity,)),
          //     ),
          //     Container(
          //       width: double.infinity,
          //       decoration: const BoxDecoration(
          //           borderRadius: BorderRadius.only(
          //               topRight: Radius.circular(40),
          //               topLeft: Radius.circular(40)),
          //           color: Color.fromRGBO(237, 195, 111, 0.616)),
          //       child: Container(
          //           width: double.infinity,
          //           height: 360,
          //           child: GridView.count(
          //             mainAxisSpacing: 15,
          //             crossAxisSpacing: 15,
          //             padding: EdgeInsets.all(23),
          //             crossAxisCount: 2,
          //             children: [
          //               DeviceBox(
          //                   deviceImagePath: ROOM1Cubit.get(context).devices[0]
          //                       [0],
          //                   deviceName: ROOM1Cubit.get(context).devices[0][1],
          //                   deviceState: ROOM1Cubit.get(context).devices[0][2],
          //                   onChange: (value) {
          //                     ROOM1Cubit.get(context).publishData(
          //                         ROOM1Cubit.get(context).devices[0][3],
          //                         value.toString());
          //                   }),
          //               DeviceBox(
          //                   deviceImagePath: ROOM1Cubit.get(context).devices[1]
          //                       [0],
          //                   deviceName: ROOM1Cubit.get(context).devices[1][1],
          //                   deviceState: ROOM1Cubit.get(context).devices[1][2],
          //                   onChange: (value) {
          //                     ROOM1Cubit.get(context).publishData(
          //                         ROOM1Cubit.get(context).devices[1][3],
          //                         value.toString());
          //                   }),
          //               DeviceBox(
          //                   deviceImagePath: ROOM1Cubit.get(context).devices[2]
          //                       [0],
          //                   deviceName: ROOM1Cubit.get(context).devices[2][1],
          //                   deviceState: ROOM1Cubit.get(context).devices[2][2],
          //                   onChange: (value) {
          //                     ROOM1Cubit.get(context).publishData(
          //                         ROOM1Cubit.get(context).devices[2][3],
          //                         value.toString());
          //                   }),
          //               DeviceBox(
          //                   deviceImagePath: ROOM1Cubit.get(context).devices[3]
          //                       [0],
          //                   deviceName: ROOM1Cubit.get(context).devices[3][1],
          //                   deviceState: ROOM1Cubit.get(context).devices[3][2],
          //                   onChange: (value) {
          //                     ROOM1Cubit.get(context).publishData(
          //                         ROOM1Cubit.get(context).devices[3][3],
          //                         value.toString());
          //                   })
          //             ],
          //           )),
          //     ),
          //   ],
          // ),
      //   );
      // }),
    );
  }
}
