import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class TemperatureGauge extends StatelessWidget {
  const TemperatureGauge(
      {super.key, required this.temperatureValue, required this.humidityValue});
  final String temperatureValue;
  final String humidityValue;
  @override
  Widget build(BuildContext context) {
    return AnimatedRadialGauge(
      duration: const Duration(seconds: 1),
      value: double.parse(temperatureValue),
      radius: 120,
      axis: GaugeAxis(
        max: 100,
        min: 0,
        degrees: 180,
        progressBar: GaugeProgressBar.rounded(
            color: getColor(double.parse(temperatureValue))),
        style: const GaugeAxisStyle(
            background: Colors.transparent, segmentSpacing: 10),
        segments: const [
          GaugeSegment(
              from: 0,
              to: 40,
              border: GaugeBorder(color: Colors.deepPurple, width: 2)),
          GaugeSegment(
              from: 40,
              to: 70,
              border: GaugeBorder(color: Colors.deepPurple, width: 2)),
          GaugeSegment(
              from: 70,
              to: 100,
              border: GaugeBorder(color: Colors.deepPurple, width: 2)),
        ],
      ),
      builder: (context, child, value) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.deepPurpleAccent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              temperatureValue,
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
            Text(
              " Humidity $humidityValue%",
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }

  Color getColor(double value) {
    if (value <= 40) {
      return Colors.yellow;
    } else if (value > 40 && value <= 70) {
      return Colors.blue;
    } else {
      return Colors.red;
    }
  }
}
