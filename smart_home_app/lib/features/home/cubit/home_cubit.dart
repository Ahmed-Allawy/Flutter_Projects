import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/features/home/cubit/home_state.dart';

import '../../../mqtt/client.dart';
import '../../../mqtt/topics.dart';

class HOMECUBIT extends Cubit<HOMESTATE> {
  late MQTTClientWrapper client;
  HOMECUBIT(this.client) : super(InitialState());
  static HOMECUBIT get(BuildContext context) => BlocProvider.of(context);

  int numberOfActiveDevices = 0;
  void getActiveDevice(String message, String topic) {
    if (topic == activeDevices) {
      print('from home cubit $message');
      this.numberOfActiveDevices = int.parse(message);
      emit(activeDevicesState());
    }
  }
}
