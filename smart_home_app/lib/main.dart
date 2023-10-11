// ignore_for_file: constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() {
  MQTTClientWrapper newclient = MQTTClientWrapper();
  newclient.prepareMqttClient();
  runApp(MyApp(
    client: newclient,
  ));
}

class MyApp extends StatefulWidget {
  MyApp({super.key, this.client});
  MQTTClientWrapper? client;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String message = '';
  @override
  void initState() {
    // TODO: implement initState
    widget.client!.client!.updates!
        .listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      var msg =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      // print('YOU GOT A NEW MESSAGE:');
      // print('alla data isssss : ${c[0].topic}');
      setState(() {
        message = msg;
      });
      print('message from callback is :$message');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('message from flutter is :$message');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 59, 61, 17)),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("HIVEMQ broker pubSub demo"),
            backgroundColor: Color.fromARGB(255, 248, 175, 5),
          ),
          body: Center(
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
                      print("from button");
                      widget.client!._publishMessage("hi from button");
                    },
                    child: Text('publish message'),
                  ),
                  SizedBox(height: 20),
                  Text('message is: $message')
                ]),
          ),
        ));
  }
}

// class MyApp extends StatelessWidget {
//   MyApp({super.key, this.client});
//   MQTTClientWrapper? client;
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     String msg = client!.callback();
//     print("msg from flutter : $msg");
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           colorScheme:
//               ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 59, 61, 17)),
//           useMaterial3: true,
//         ),
//         home: Scaffold(
//           appBar: AppBar(
//             centerTitle: true,
//             title: Text("HIVEMQ broker pubSub demo"),
//             backgroundColor: Color.fromARGB(255, 248, 175, 5),
//           ),
//           body: Center(
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
//                       print("from button");
//                       client!._publishMessage("hi from button");
//                     },
//                     child: Text('publish message'),
//                   ),
//                   Text("")
//                 ]),
//           ),
//         ));
//   }
// }

// connection states for easy identification
enum MqttCurrentConnectionState {
  IDLE,
  CONNECTING,
  CONNECTED,
  DISCONNECTED,
  ERROR_WHEN_CONNECTING
}

enum MqttSubscriptionState { IDLE, SUBSCRIBED }

class MQTTClientWrapper {
  MqttServerClient? client;

  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

  // using async tasks, so the connection won't hinder the code flow
  void prepareMqttClient() async {
    _setupMqttClient();
    await _connectClient();
    _subscribeToTopic('Dart/Mqtt_client/testtopic');
    // _publishMessage('Hello');
  }

  // waiting for the connection, if an error occurs, print it and disconnect
  Future<void> _connectClient() async {
    try {
      print('client connecting....');
      connectionState = MqttCurrentConnectionState.CONNECTING;

      /// i am here
      await client!.connect('Ahmed-Allawy', 'Ahmed-Allawy-password');
    } on Exception catch (e) {
      print('client exception - $e');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client!.disconnect();
    }

    // when connected, print a confirmation, else print an error
    if (client!.connectionStatus!.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.CONNECTED;
      print('client connected');
    } else {
      print(
          'ERROR client connection failed - disconnecting, status is ${client!.connectionStatus}');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client!.disconnect();
    }
  }

  void _setupMqttClient() {
    client = MqttServerClient.withPort(
        '682e58128e844617be6d3f57807aa235.s2.eu.hivemq.cloud',
        'Ahmed-Allawy',
        8883);
    // the next 2 lines are necessary to connect with tls, which is used by HiveMQ Cloud
    client!.secure = true;
    client!.securityContext = SecurityContext.defaultContext;
    client!.keepAlivePeriod = 20;
    client!.onDisconnected = _onDisconnected;
    client!.onConnected = _onConnected;
    client!.onSubscribed = _onSubscribed;
  }

  void _subscribeToTopic(String topicName) {
    print('Subscribing to the $topicName topic');
    client!.subscribe(topicName, MqttQos.atMostOnce);
    // var message = '';
    // // print the message when it is received
    // client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    //   final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
    //   message =
    //       MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    //   // print('YOU GOT A NEW MESSAGE:');
    //   print('message from callback is :$message');
    // });
  }

  void _publishMessage(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    print(
        'Publishing message "$message" to topic ${'Dart/Mqtt_client/testtopic'}');
    client!.publishMessage(
        'Dart/Mqtt_client/testtopic', MqttQos.exactlyOnce, builder.payload!);
  }

  // callbacks for different events
  void _onSubscribed(String topic) {
    print('Subscription confirmed for topic $topic');
    subscriptionState = MqttSubscriptionState.SUBSCRIBED;
  }

  void _onDisconnected() {
    print('OnDisconnected client callback - Client disconnection');
    connectionState = MqttCurrentConnectionState.DISCONNECTED;
  }

  void _onConnected() {
    connectionState = MqttCurrentConnectionState.CONNECTED;
    print('OnConnected client callback - Client connection was sucessful');
  }
}
