// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../../core/util/topics.dart';
import 'ui_state.dart';

class UICubit extends Cubit<UIState> {
  final MqttClientPayloadBuilder _p = MqttClientPayloadBuilder();
  UICubit() : super(InitialState());
  static UICubit get(BuildContext context) => BlocProvider.of(context);

  void publish(MqttServerClient client, String topic, String data) {
    _p.addString(data);
    client.publishMessage(topic, MqttQos.atMostOnce, _p.payload!, retain: true);
    _p.clear();
  }

  void getDataAndTopic(List<MqttReceivedMessage<MqttMessage>> event) {
    final MqttPublishMessage message = event[0].payload as MqttPublishMessage;
    final data =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);
    routeData(event[0].topic, data);
  }

  List<SaleChartData> chartDataSource = [
    SaleChartData(1, 35),
    SaleChartData(2, 25),
    SaleChartData(3, 45),
    SaleChartData(4, 35),
  ];
  String temperature = '30';
  String humidity = '70';
  void routeData(String topic, String data) {
    if (topic == Topics.light1LivingRoomTopic) {
    } else if (topic == Topics.fanLivingRoomTopic) {
    } else if (topic == Topics.tvLivingRoomTopic) {
    } else if (topic == Topics.airLivingRoomTopic) {
    } else if (topic == Topics.temperatureTopic) {
      if (chartDataSource.length > 10) {
        chartDataSource.removeAt(0);
      }
      chartDataSource
          .add(SaleChartData((chartDataSource.length + 1), double.parse(data)));
      temperature = data;
    } else if (topic == Topics.humidityTopic) {
      humidity = data;
    }
    emit(GetDataState());
  }
}

class SaleChartData {
  SaleChartData(this.x, this.y);
  final double x;
  final double y;
}
