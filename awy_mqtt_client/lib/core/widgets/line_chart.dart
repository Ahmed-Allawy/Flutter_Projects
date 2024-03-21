import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../features/ui_screen/cubit/ui_cubit.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({
    super.key,
    required this.dataSource,
  });
  final List<SaleChartData> dataSource;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: SfCartesianChart(
        primaryYAxis: const NumericAxis(
            interval: 5,
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            title: AxisTitle(
                text: "temperature",
                textStyle: TextStyle(color: Colors.black))),
        primaryXAxis: const NumericAxis(
            interval: 1,
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            title: AxisTitle(
                text: "time", textStyle: TextStyle(color: Colors.black))),
        series: [
          LineSeries<SaleChartData, int>(
            color: Colors.deepPurple,
            dataSource: dataSource,
            xValueMapper: (SaleChartData salse, _) => salse.x,
            yValueMapper: (SaleChartData salse, _) => salse.y,
          )
        ],
      ),
    );
  }
}
