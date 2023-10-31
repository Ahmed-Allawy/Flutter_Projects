import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../features/home/cubit/home_cubit.dart';

class TemperatureChart extends StatefulWidget {
  TemperatureChart(
      {Key? key, required this.title, required this.temperatureValue})
      : super(key: key);

  final String title;
  final num temperatureValue;
  @override
  _MyTemperatureChartState createState() => _MyTemperatureChartState();
}

class _MyTemperatureChartState extends State<TemperatureChart> {
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;

  @override
  void initState() {
    chartData = getChartData();
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        series: <LineSeries<LiveData, int>>[
          LineSeries<LiveData, int>(
            onRendererCreated: (ChartSeriesController controller) {
              _chartSeriesController = controller;
            },
            dataSource: chartData,
            color: Color.fromARGB(255, 221, 52, 26),
            xValueMapper: (LiveData sales, _) => sales.time,
            yValueMapper: (LiveData sales, _) => sales.temp,
          )
        ],
        primaryXAxis: NumericAxis(
            majorGridLines: const MajorGridLines(width: 0),
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            interval: 3,
            title: AxisTitle(text: 'Time (seconds)')),
        primaryYAxis: NumericAxis(
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0),
            title: AxisTitle(text: widget.title)));
  }

  int time = 7;
  void updateDataSource(Timer timer) {
    if (widget.temperatureValue != chartData[chartData.length - 1]) {
       print('data to chart = ${widget.temperatureValue}');
      chartData.add(LiveData(time++, widget.temperatureValue));
      if (chartData.length >= 18) {
        chartData.removeAt(0);
        _chartSeriesController.updateDataSource(
            addedDataIndex: chartData.length - 1, removedDataIndex: 0);
      } else {
        _chartSeriesController.updateDataSource(
          addedDataIndex: chartData.length - 1,
        );
      }
    }
    else{
      print('no new data');
    }
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 42),
      LiveData(1, 47),
      // LiveData(2, 43),
      // LiveData(3, 49),
      // LiveData(4, 54),
      // LiveData(5, 41),
      // LiveData(6, 58),
      // LiveData(7, 51),
    ];
  }
}

