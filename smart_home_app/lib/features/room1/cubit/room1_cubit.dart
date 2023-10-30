// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/core/utils/assets.dart';

import '../../../mqtt/client.dart';
import '../../../mqtt/topics.dart';
import 'room1_state.dart';

class ROOM1Cubit extends Cubit<ROOM1State> {
  late MQTTClientWrapper client;
  ROOM1Cubit(this.client) : super(InitialState());

  static ROOM1Cubit get(BuildContext context) => BlocProvider.of(context);

  List devices = [
    [Assets.lumpImage, 'Lump 1', true, lump1Room1],
    [Assets.fanImage, 'Fan', false, fanRoom1],
    [Assets.airConditionerImage, 'Air Conditioner', false, airConditionerRoom1],
    [Assets.tvImage, 'TV', true, tvRoom1],
  ];
  // String lump1State = '';
  // String tvState = '';
  // String fanState = '';
  // String airConditionerState = '';
  String temperature = '';
  String humidity = '';
  int count = 0;
  void listenToBroker(String message, String topic) {
    if (topic == temRoom1) {
      this.temperature = message;
    }
    if (topic == humRoom1) {
      this.humidity = message;
    }
    for (var device in devices) {
      if (topic == device[3]) {
        if (message=='false') {
           device[2] = false;
        }
        else{
           device[2] = true;
        }
       
      }
    }
    print('done!');
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
