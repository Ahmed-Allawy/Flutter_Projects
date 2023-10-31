import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/core/network/cach_helper.dart';
import 'package:smart_home_app/features/home/cubit/home_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/widgets/chart.dart';
import '../../../mqtt/client.dart';
import '../../../mqtt/topics.dart';

class HOMECUBIT extends Cubit<HOMESTATE> {
  late MQTTClientWrapper client;
  HOMECUBIT(this.client) : super(InitialState());
  static HOMECUBIT get(BuildContext context) => BlocProvider.of(context);

  String getActiveDevice() {
    if (CacheHelper.getData(key: 'numberOfActiveDevices') != null) {
      String d = CacheHelper.getData(key: 'numberOfActiveDevices').toString();
      emit(activeDevicesState());
      return d;
      // print(CacheHelper.getData(key: 'numberOfActiveDevices'));
    } else {
      CacheHelper.saveData(key: 'numberOfActiveDevices', value: '0');
      emit(activeDevicesState());
      return '0';
    }
  }

  String temperature = '37';
  int time = 2;
  late ChartSeriesController chartSeriesController;
  late List<LiveData> chartData = getChartData();
  void listenToBroker(String message, String topic) {
    if (topic == temRoom1) {
      this.temperature = message;
       chartData.add(LiveData(time++, num.parse(message)));
      if(chartData.length>18){
         print('length =  ${chartData.length}');
        chartData.removeAt(0);
      }
      
    
      emit(ReceivedDataState());
    }
  }

  // void updateDataSource(Timer timer) {
  //   // print('data to chart = ${widget.temperatureValue}');
  //   chartData.add(LiveData(time++, num.parse(temperature)));
  //   if (chartData.length >= 18) {
  //     chartData.removeAt(0);
  //     chartSeriesController.updateDataSource(
  //         addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  //   } else {
  //     chartSeriesController.updateDataSource(
  //       addedDataIndex: chartData.length - 1,
  //     );
  //   }
  // }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 42),
      LiveData(1, 47),
      LiveData(2, 43),
      // LiveData(3, 49),
      // LiveData(4, 54),
      // LiveData(5, 41),
      // LiveData(6, 58),
      // LiveData(7, 51),
    ];
  }
}
class LiveData {
  LiveData(this.time, this.temp);
  final int time;
  final num temp;
}

