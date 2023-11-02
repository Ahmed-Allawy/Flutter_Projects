import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../features/home/cubit/home_cubit.dart';

class chart extends StatelessWidget {
  chart({
    super.key,
    required this.label,
   
    required this.chartData,
  });
  final String label;
 
  final List<LiveData> chartData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 170,
        child: SfCartesianChart(
          series: <LineSeries<LiveData, int>>[
            LineSeries<LiveData, int>(
              onRendererCreated: (ChartSeriesController controller) {
                 HOMECUBIT.get(context).chartSeriesController = controller;
              },
              dataSource: chartData,
              color: Color.fromARGB(255, 221, 52, 26),
              xValueMapper: (LiveData sales, _) => sales.time,
              yValueMapper: (LiveData sales, _) => sales.temp,
            ),
          ],
          primaryXAxis: NumericAxis(
              majorGridLines: const MajorGridLines(width: 0),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              interval: 3,
              title: AxisTitle(
                  text: 'Time (seconds)',
                  textStyle: TextStyle(color: Colors.white))),
          primaryYAxis: NumericAxis(
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(size: 0),
              title: AxisTitle(
                  text: 'Temperature',
                  textStyle: TextStyle(color: Colors.white))),
        ));
  }
}
