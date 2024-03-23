import 'package:awy_mqtt_client/core/util/topics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../../core/util/assets.dart';
import '../../core/widgets/custom_container.dart';
import '../../core/widgets/line_chart.dart';
import '../../core/widgets/temperature_gauge.dart';
import 'cubit/ui_cubit.dart';
import 'cubit/ui_state.dart';

class AdvancedUiScreen extends StatefulWidget {
  const AdvancedUiScreen({super.key, required this.client});
  final MqttServerClient? client;

  @override
  State<AdvancedUiScreen> createState() => _AdvancedUiScreenState();
}

class _AdvancedUiScreenState extends State<AdvancedUiScreen> {
  @override
  void initState() {
    widget.client!.updates!.listen((event) {
      // UICubit.get(context).getDataAndTopic(event);
      if (mounted) {
        UICubit.get(context).getDataAndTopic(event);
      }
    });

    widget.client!.subscribe(Topics.temperatureTopic, MqttQos.atMostOnce);
    widget.client!.subscribe(Topics.humidityTopic, MqttQos.atMostOnce);
    widget.client!.subscribe(Topics.lightTopic, MqttQos.atMostOnce);
    widget.client!.subscribe(Topics.tvTopic, MqttQos.atMostOnce);
    widget.client!.subscribe(Topics.switchOneTopic, MqttQos.atMostOnce);
    widget.client!.subscribe(Topics.switchTwoTopic, MqttQos.atMostOnce);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomContainer(
                  secondWidget: BlocBuilder<UICubit, UIState>(
                    builder: (context, state) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            Assets.light1LivingRoomImg,
                            color: UICubit.get(context).light
                                ? Colors.green
                                : Colors.black,
                            width: 70,
                            height: 70,
                          ),
                          onTap: () {
                            bool value = UICubit.get(context).light ^ true;
                            String data = value.toString();
                            UICubit.get(context).publish(
                                widget.client!, Topics.lightTopic, data);
                          },
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            Assets.tvLivingRoomImg,
                            color: UICubit.get(context).tv
                                ? Colors.green
                                : Colors.black,
                            width: 60,
                            height: 60,
                          ),
                          onTap: () {
                            bool value = UICubit.get(context).tv ^ true;
                            String data = value.toString();
                            UICubit.get(context)
                                .publish(widget.client!, Topics.tvTopic, data);
                          },
                        ),
                        Switch(
                          value: UICubit.get(context).switchOne,
                          onChanged: (value) {
                            UICubit.get(context).publish(widget.client!,
                                Topics.switchOneTopic, value.toString());
                          },
                          activeColor: Colors.green,
                        ),
                        Transform.rotate(
                          angle: (22 / 7) / 2,
                          child: Switch(
                            value: UICubit.get(context).switchTwo,
                            onChanged: (value) {
                              UICubit.get(context).publish(widget.client!,
                                  Topics.switchTwoTopic, value.toString());
                            },
                            activeColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  label:
                      'Controllers topics: ${Topics.lightTopic}\n${Topics.tvTopic}\n${Topics.switchOneTopic}\n${Topics.switchTwoTopic}'),
              const SizedBox(
                height: 25,
              ),
              CustomContainer(
                secondWidget: BlocBuilder<UICubit, UIState>(
                  builder: (context, state) => TemperatureGauge(
                    temperatureValue: UICubit.get(context).temperature,
                    humidityValue: UICubit.get(context).humidity,
                  ),
                ),
                // secondWidget: Text('data'),
                label:
                    'Gauge topics: ${Topics.temperatureTopic}\n${Topics.humidityTopic}',
              ),
              const SizedBox(
                height: 25,
              ),
              CustomContainer(
                  secondWidget: BlocBuilder<UICubit, UIState>(
                    builder: (BuildContext context, state) {
                      return LineChartWidget(
                          dataSource: UICubit.get(context).chartDataSource);
                    },
                  ),
                  label: 'Chart topic: ${Topics.temperatureTopic}'),
            ],
          ),
        ),
      ),
    );
  }
}
