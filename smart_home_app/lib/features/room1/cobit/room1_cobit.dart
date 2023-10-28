// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../mqtt/client.dart';
import 'room1_state.dart';

class ROOM1Cubit extends Cubit<ROOM1State> {
  late MQTTClientWrapper client;
  ROOM1Cubit(this.client) : super(InitialState());

  static ROOM1Cubit get(BuildContext context) => BlocProvider.of(context);

  String lump1State = '';
  int count = 0;
  void listenToBroker(String message) {
    lump1State = message;
    emit(ReceivedDataState());
  }

  void publishData(String topic, String message) {
    client.publishMessage(message, topic);
    count++;
    emit(PublishState());
  }

  void subscribeToTopic(String topic) {
    client.subscribeToTopic(topic);
    emit(SubscribeToTopicState());
  }
}
