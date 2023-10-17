// ignore_for_file: constant_identifier_names, must_be_immutable, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_home_app/features/room1/cobit/room1_cobit.dart';
import 'package:smart_home_app/features/room1/room1.dart';
import 'mqtt/client.dart';

void main() async {
  await dotenv.load(fileName: "lib/.env");
  MQTTClientWrapper newclient = MQTTClientWrapper();
  newclient.prepareMqttClient().then((value) {
    runApp(MyApp(
      client: newclient,
      mqttStatus: value,
    ));
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key, this.client, this.mqttStatus});
  MQTTClientWrapper? client;
  bool? mqttStatus;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return mqttStatus!
        ? MultiBlocProvider(
            providers: [
                BlocProvider(create: ((context) => ROOM1Cubit(client!))),
              ],
            child:
                MaterialApp(debugShowCheckedModeBanner: false, home: Room1()))
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("HIVEMQ broker (Smart Home)"),
                backgroundColor: const Color.fromARGB(255, 248, 175, 5),
              ),
              body: Center(
                  child: Text('you are offline, mqttStatus is $mqttStatus')),
            ),
          );
  }
}
