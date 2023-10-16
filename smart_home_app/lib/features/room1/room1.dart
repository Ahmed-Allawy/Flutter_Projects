// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_home_app/features/room1/cobit/room1_cobit.dart';
import 'package:smart_home_app/features/room1/cobit/room1_state.dart';
import 'package:smart_home_app/mqtt/topics.dart';

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
      appBar: AppBar(
        centerTitle: true,
        title: const Text("HIVEMQ broker (Smart Home)"),
        backgroundColor: const Color.fromARGB(255, 248, 175, 5),
      ),
      body: BlocBuilder<ROOM1Cubit, ROOM1State>(
        builder: (context, state) {
          return Center(
            // child: Text(msg),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5);
                          }
                          return null; // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () {
                      ROOM1Cubit.get(context).publishData(
                          lump1Room1, ROOM1Cubit.get(context).count.toString());
                    },
                    child: const Text('publish message'),
                  ),
                  const SizedBox(height: 50),
                  Text('lump is: ${ROOM1Cubit.get(context).lump1State}')
                ]),
          );
        },
      ),
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
