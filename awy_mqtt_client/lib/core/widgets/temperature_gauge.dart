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
      radius: 105,
      axis: GaugeAxis(
        max: 100,
        min: 0,
        degrees: 180,
        progressBar: GaugeProgressBar.rounded(
            color: getColor(double.parse(temperatureValue))),
        style: const GaugeAxisStyle(
            background: Colors.transparent, segmentSpacing: 5),
        segments: const [
          GaugeSegment(
              from: 0,
              to: 25,
              border: GaugeBorder(color: Colors.deepPurple, width: 2)),
          GaugeSegment(
              from: 26,
              to: 51,
              border: GaugeBorder(color: Colors.deepPurple, width: 2)),
          GaugeSegment(
              from: 52,
              to: 75,
              border: GaugeBorder(color: Colors.deepPurple, width: 2)),
          GaugeSegment(
              from: 76,
              to: 100,
              border: GaugeBorder(color: Colors.deepPurple, width: 2)),
        ],
      ),
      builder: (context, child, value) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromARGB(148, 124, 77, 255),
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
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Color getColor(double value) {
    if (value <= 25) {
      return const Color.fromARGB(255, 59, 255, 248);
    } else if (value <= 50) {
      return Colors.blue;
    } else if (value <= 75) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
