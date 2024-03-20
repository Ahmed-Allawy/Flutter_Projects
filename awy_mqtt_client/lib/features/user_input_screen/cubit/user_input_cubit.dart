// ignore_for_file: avoid_print

import 'package:awy_mqtt_client/features/user_input_screen/cubit/user_input_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class UserInputCubit extends Cubit<UserInputState> {
  List<String> data = [];
  int dataLength = 0;
  final MqttClientPayloadBuilder _p = MqttClientPayloadBuilder();
  UserInputCubit() : super(InitialState());
  static UserInputCubit get(BuildContext context) => BlocProvider.of(context);

  void publish(MqttServerClient client, String topic, String data) {
    _p.addString(data);
    client.publishMessage(topic, MqttQos.atMostOnce, _p.payload!, retain: true);
    _p.clear();
  }

  void getDataAndTopic(List<MqttReceivedMessage<MqttMessage>> event) {
    final MqttPublishMessage message = event[0].payload as MqttPublishMessage;
    final msg =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);
    if (data.length > 20) {
      data.removeAt(0);
    }
    data.add(msg);
    dataLength = data.length;
    emit(GetDataState());
  }
}
