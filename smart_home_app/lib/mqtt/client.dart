// ignore_for_file: unused_element, avoid_print, constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';


// import 'package:mqtt_client/mqtt_browser_client.dart';

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
  // MqttBrowserClient? client;

  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

  // using async tasks, so the connection won't hinder the code flow
  Future<bool> prepareMqttClient() async {
    _setupMqttClient();
    String status = await _connectClient();
    if (status == 'connected') {
      // subscribe to topics
     
      return true;
    } else {
      return false;
    }
  }

  // waiting for the connection, if an error occurs, print it and disconnect
  Future<String> _connectClient() async {
    try {
      print('client connecting....');
      connectionState = MqttCurrentConnectionState.CONNECTING;

      /// i am here
      // await client!.connect(dotenv.env['USER_NAME']!, dotenv.env['PASSWORD']!);
      await client!.connect();
    } on Exception catch (e) {
      print('client exception - $e');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client!.disconnect();
      return 'exception';
    }

    // when connected, print a confirmation, else print an error
    if (client!.connectionStatus!.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.CONNECTED;
      print('client connected');
      return 'connected';
    } else {
      print(
          'ERROR client connection failed - disconnecting, status is ${client!.connectionStatus}');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client!.disconnect();
      return 'failed';
    }
  }

  void _setupMqttClient() {
    client = MqttServerClient.withPort(dotenv.env['URI']!,
        dotenv.env['USER_NAME']!, int.parse(dotenv.env['PORT']!));
    // client!.secure = true;
    // client!.securityContext = SecurityContext.defaultContext;
    // client =  MqttBrowserClient(dotenv.env['URI']!, 'clientIdentifier');
    // client!.port = int.parse(dotenv.env['PORT']!);
    // client!.websocketProtocols = MqttClientConstants.protocolsSingleDefault;
    client!.keepAlivePeriod = 20;
    client!.onDisconnected = _onDisconnected;
    client!.onConnected = _onConnected;
    client!.onSubscribed = _onSubscribed;
  }

  void subscribeToTopic(String topicName) {
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

  void publishMessage(String message, String topic) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    print('Publishing message "$message" to topic $topic');
    client!.publishMessage(topic, MqttQos.atMostOnce, builder.payload!,
        retain: true);
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
