import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../core/util/assets.dart';
import '../../core/util/topics.dart';
import '../../core/widgets/devices_card.dart';
import '../../core/widgets/temperature_gauge.dart';
import 'cubit/livingroom_cubit.dart';
import 'cubit/livingroom_state.dart';

class LivingRoom extends StatefulWidget {
  const LivingRoom({super.key});

  @override
  State<LivingRoom> createState() => _LivingRoomState();
}

class _LivingRoomState extends State<LivingRoom> {
  @override
  void initState() {
    LivingRoomCubit.get(context)
        .client
        .subscribe(Topics.light1LivingRoomTopic, MqttQos.atMostOnce);
    LivingRoomCubit.get(context)
        .client
        .subscribe(Topics.fanLivingRoomTopic, MqttQos.atMostOnce);
    LivingRoomCubit.get(context)
        .client
        .subscribe(Topics.tvLivingRoomTopic, MqttQos.atMostOnce);
    LivingRoomCubit.get(context)
        .client
        .subscribe(Topics.airLivingRoomTopic, MqttQos.atMostOnce);
    LivingRoomCubit.get(context)
        .client
        .subscribe(Topics.temperatureTopic, MqttQos.atMostOnce);
    LivingRoomCubit.get(context)
        .client
        .subscribe(Topics.humidityTopic, MqttQos.atMostOnce);
    LivingRoomCubit.get(context).client.updates!.listen((event) {
      LivingRoomCubit.get(context).getDataAndTopic(event);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Living Room"),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {},
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.srgbToLinearGamma(),
                image: AssetImage(Assets.livingRoomImg),
                fit: BoxFit.fill)),
        child: BlocBuilder<LivingRoomCubit, LivingRoomState>(
          builder: (BuildContext context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TemperatureGauge(
                  temperatureValue: LivingRoomCubit.get(context).temperature,
                  humidityValue: LivingRoomCubit.get(context).humidity,
                ),
                Container(
                  width: double.infinity,
                  height: 380,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(144, 244, 67, 54),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50))),
                  child: GridView.count(
                    padding: const EdgeInsets.only(top: 20.0),
                    crossAxisCount: 2,
                    children: [
                      DevicesCard(
                        deviceName: 'Light',
                        deviceImage: Assets.light1LivingRoomImg,
                        onChanged: (value) {
                          LivingRoomCubit.get(context).publish(
                              Topics.light1LivingRoomTopic, value.toString());
                        },
                        deviceState: LivingRoomCubit.get(context).light1,
                      ),
                      DevicesCard(
                        deviceName: 'Fan',
                        deviceImage: Assets.fanLivingRoomImg,
                        onChanged: (value) {
                          LivingRoomCubit.get(context).publish(
                              Topics.fanLivingRoomTopic, value.toString());
                        },
                        deviceState: LivingRoomCubit.get(context).fan,
                      ),
                      DevicesCard(
                        deviceName: 'smart-tv',
                        deviceImage: Assets.tvLivingRoomImg,
                        onChanged: (value) {
                          LivingRoomCubit.get(context).publish(
                              Topics.tvLivingRoomTopic, value.toString());
                        },
                        deviceState: LivingRoomCubit.get(context).tv,
                      ),
                      DevicesCard(
                        deviceName: 'Air-conditioner',
                        deviceImage: Assets.conditionerLivingRoomImg,
                        onChanged: (value) {
                          LivingRoomCubit.get(context).publish(
                              Topics.airLivingRoomTopic, value.toString());
                        },
                        deviceState: LivingRoomCubit.get(context).air,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
