import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/core/network/cach_helper.dart';
import 'package:smart_home_app/features/home/cubit/home_state.dart';

import '../../../mqtt/client.dart';

class HOMECUBIT extends Cubit<HOMESTATE> {
  late MQTTClientWrapper client;
  HOMECUBIT(this.client) : super(InitialState());
  static HOMECUBIT get(BuildContext context) => BlocProvider.of(context);

  String getActiveDevice() {
    if (CacheHelper.getData(key: 'numberOfActiveDevices') != null) {
      print('have value');

      String d = CacheHelper.getData(key: 'numberOfActiveDevices').toString();
            emit(activeDevicesState());
      return d;
      // print(CacheHelper.getData(key: 'numberOfActiveDevices'));
    } else {
      print('not created yet');
      CacheHelper.saveData(key: 'numberOfActiveDevices', value: '0');
      emit(activeDevicesState());
      return '0';
    }
  }
}
