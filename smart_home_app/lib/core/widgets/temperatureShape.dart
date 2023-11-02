import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class TempShape extends StatefulWidget {
  const TempShape({super.key, required this.tValue, required this.hValue});
  final String tValue;
  final String hValue;
  @override
  State<TempShape> createState() => _TempShapeState();
}

class _TempShapeState extends State<TempShape> {
  @override
  Widget build(BuildContext context) {
    return AnimatedRadialGauge(
      /// The animation duration.
      duration: const Duration(seconds: 1),
      curve: Curves.elasticOut,

      /// Define the radius.
      /// If you omit this value, the parent size will be used, if possible.
      radius: 120,

      /// Gauge value.
      value: double.parse(widget.tValue),

      /// Optionally, you can configure your gauge, providing additional
      /// styles and transformers.
      axis: GaugeAxis(
        /// Provide the [min] and [max] value for the [value] argument.
        min: -0,
        max: 100,

        /// Render the gauge as a 180-degree arc.
        degrees: 180,

        /// Set the background color and axis thickness.
        style: const GaugeAxisStyle(
          thickness: 20,
          background: Colors.transparent,
          segmentSpacing: 6,
        ),
        progressBar:  GaugeProgressBar.rounded(
          color: getColor(double.parse(widget.tValue)),
        ),

        /// Define axis segments (optional).
        segments: [
          const GaugeSegment(
              from: 0,
              to: 20.2,
              color: Colors.transparent,
              cornerRadius: Radius.zero,
              border: GaugeBorder(
                  color: Color.fromRGBO(237, 195, 111, 0.416), width: 2.0)),
          const GaugeSegment(
              from: 20.2,
              to: 50.4,
              color: Colors.transparent,
              cornerRadius: Radius.zero,
              border: GaugeBorder(
                  color: Color.fromRGBO(237, 195, 111, 0.416), width: 2.0)),
          const GaugeSegment(
              from: 50.4,
              to: 75.6,
              color: Colors.transparent,
              cornerRadius: Radius.zero,
              border: GaugeBorder(
                  color: Color.fromRGBO(237, 195, 111, 0.416), width: 2.0)),
          const GaugeSegment(
              from: 75.6,
              to: 100,
              color: Colors.transparent,
              cornerRadius: Radius.zero,
              border: GaugeBorder(
                  color: Color.fromRGBO(237, 195, 111, 0.416), width: 2.0)),
        ],
      ),
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(237, 195, 111, 0.416),
              borderRadius: BorderRadius.circular(50)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.tValue,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Humidity ${widget.hValue}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Color getColor(double value) {
    if (value < 21) {
      return Colors.white;
    } else if (value >= 21 && value < 51) {
      return Colors.blue;
    }
    else if (value >= 51 && value <=75) {
      return Colors.yellow;
    }
    else  {
      return Colors.red;
    }
  }
}
