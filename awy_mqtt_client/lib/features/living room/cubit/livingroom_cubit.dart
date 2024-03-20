// ignore_for_file: avoid_print

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../../core/util/shared.dart';
import '../../../core/util/topics.dart';
import 'livingroom_state.dart';

class LivingRoomCubit extends Cubit<LivingRoomState> {
  late MqttServerClient client;
  final MqttClientPayloadBuilder _p = MqttClientPayloadBuilder();
  LivingRoomCubit(this.client) : super(InitialState());
  static LivingRoomCubit get(BuildContext context) => BlocProvider.of(context);

  void publish(String topic, String data) {
    _p.addString(data);
    client.publishMessage(topic, MqttQos.atMostOnce, _p.payload!, retain: true);
    _p.clear();
  }

  void getDataAndTopic(List<MqttReceivedMessage<MqttMessage>> event) {
    final MqttPublishMessage message = event[0].payload as MqttPublishMessage;
    final data =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);
    routeData(event[0].topic, data);
    setActiveDevices();
  }

  bool light1 = false;
  bool tv = false;
  bool fan = false;
  bool air = false;
  String temperature = "30";
  String humidity = "30";
  void routeData(String topic, String data) {
    if (topic == Topics.light1LivingRoomTopic) {
      light1 = bool.parse(data);
      emit(GetDataState());
    } else if (topic == Topics.fanLivingRoomTopic) {
      fan = bool.parse(data);
      emit(GetDataState());
    } else if (topic == Topics.tvLivingRoomTopic) {
      tv = bool.parse(data);
      emit(GetDataState());
    } else if (topic == Topics.airLivingRoomTopic) {
      air = bool.parse(data);
      emit(GetDataState());
    } else if (topic == Topics.temperatureTopic) {
      temperature = data;
      emit(GetDataState());
    } else if (topic == Topics.humidityTopic) {
      humidity = data;
      emit(GetDataState());
    }
  }

  int count = 0;
  void setActiveDevices() {
    count = 0;
    if (light1 == true) {
      count++;
    }
    if (tv == true) {
      count++;
    }
    if (fan == true) {
      count++;
    }
    if (air == true) {
      count++;
    }
    Shared.saveData(key: 'activeDevices', value: count.toString());
    print("count = $count");
  }
}
