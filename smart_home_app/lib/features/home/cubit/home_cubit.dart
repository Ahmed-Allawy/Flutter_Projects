
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/features/home/cubit/home_state.dart';

class HOMECUBIT extends Cubit<HOMESTATE> {
  HOMECUBIT() : super(InitialState());

  static HOMECUBIT get(BuildContext context) => BlocProvider.of(context);

  int devices = 0;
  int activeDevices = 0;
  
  void getActiveDevice(List devices){
    for (var element in devices) {
      if(element[2]==true){
        activeDevices++;
      }
    }
    emit(activeDevicesState());
  }
}