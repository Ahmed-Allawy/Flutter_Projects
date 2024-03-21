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

  // void dumyData(String data) {
  //   print(data);
  // }

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
  bool light = false;
  bool tv = false;
  bool switchOne = false;
  bool switchTwo = false;
  String temperature = '30';
  String humidity = '70';

  void routeData(String topic, String data) {
    if (topic == Topics.lightTopic) {
      light = bool.parse(data);
    } else if (topic == Topics.tvTopic) {
      tv = bool.parse(data);
    } else if (topic == Topics.switchOneTopic) {
      switchOne = bool.parse(data);
    } else if (topic == Topics.switchTwoTopic) {
      switchTwo = bool.parse(data);
    } else if (topic == Topics.temperatureTopic) {
      // if (chartDataSource.length <= 5) {
      //   chartDataSource.add(
      //       SaleChartData((chartDataSource.length + 1), double.parse(data)));
      // } else {
      //   chartDataSource.removeAt(0);
      //   chartDataSource.add(
      //       SaleChartData((chartDataSource.length + 1), double.parse(data)));
      // }

      // print(chartDataSource.length);
      chartDataSource
          .add(SaleChartData((chartDataSource.length + 1), double.parse(data)));
      // if (chartDataSource.length >= 10) {
      //   chartDataSource.removeAt(0);
      // }
      temperature = data;
    } else if (topic == Topics.humidityTopic) {
      humidity = data;
    }
    emit(GetDataState());
  }
}

class SaleChartData {
  SaleChartData(this.x, this.y);
  final int x;
  final double y;
}
