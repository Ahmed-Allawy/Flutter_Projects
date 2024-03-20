import 'package:awy_mqtt_client/core/util/topics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../../core/widgets/line_chart.dart';
import '../../core/widgets/temperature_gauge.dart';
import 'cubit/ui_cubit.dart';
import 'cubit/ui_state.dart';

class AdvancedUiScreen extends StatelessWidget {
  const AdvancedUiScreen({super.key, required this.client});
  final MqttServerClient? client;

  @override
  Widget build(BuildContext context) {
    client!.updates!.listen((event) {
      UICubit.get(context).getDataAndTopic(event);
    });
    client!.subscribe(Topics.temperatureTopic, MqttQos.atMostOnce);
    client!.subscribe(Topics.humidityTopic, MqttQos.atMostOnce);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Advanced Ui',
          style: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: [
                  const Text(
                    'Gauge topic: ${Topics.temperatureTopic}\n${Topics.humidityTopic}',
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<UICubit, UIState>(
                    builder: (context, state) => TemperatureGauge(
                      temperatureValue: UICubit.get(context).temperature,
                      humidityValue: UICubit.get(context).humidity,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Column(
                children: [
                  const Text(
                    'Chart topic: ${Topics.temperatureTopic}',
                    style: TextStyle(fontSize: 15),
                  ),
                  BlocBuilder<UICubit, UIState>(
                    builder: (BuildContext context, state) {
                      return LineChartWidget(
                          dataSource: UICubit.get(context).chartDataSource);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
