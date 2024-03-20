// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:awy_mqtt_client/core/util/assets.dart';
import 'package:awy_mqtt_client/core/widgets/custom_box.dart';
import 'package:awy_mqtt_client/features/broker_screen/broker.dart';
import 'package:awy_mqtt_client/features/ui_screen/ui.dart';
import 'package:awy_mqtt_client/features/user_input_screen/user_input.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../core/util/error_dialog.dart';
import '../../core/util/loading_dialog.dart';
import '../../core/util/shared.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isloading = false;
  late MqttServerClient client;
  @override
  void initState() {
    String broker = Shared.getData(key: 'broker');
    int port = Shared.getData(key: 'port');
    client = MqttServerClient.withPort(broker, "clientIdentifier", port);
    String userName = Shared.getData(key: 'userName') ?? '';
    String password = Shared.getData(key: 'password') ?? '';
    connectToBroker(context, client, userName, password).then((value) {
      if (value) {
        setState(() {
          isloading = true;
        });
        Shared.saveData(key: 'clientConnected', value: true);
        // widget.client!.subscribe('allawy/ahmed', MqttQos.atMostOnce);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(102, 43, 38, 38),
        body: isloading
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      flex: 3,
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.0,
                        children: [
                          InkWell(
                            child: const CustomBox(
                                name: 'Pub/Sub Data',
                                img: Assets.pubSubImg,
                                effect: true),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserInputScreen(
                                            client: client,
                                          )));
                            },
                          ),
                          InkWell(
                            child: const CustomBox(
                                name: 'Broker Config',
                                img: Assets.brokerConfigImg,
                                effect: false),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BrokerConfigScreen()));
                            },
                          ),
                          InkWell(
                            child: const CustomBox(
                                name: 'Advanced Ui',
                                img: Assets.uiImg,
                                effect: true),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdvancedUiScreen(
                                            client: client,
                                          )));
                            },
                          ),
                          const CustomBox(
                              name: 'Mobile Sensors',
                              img: Assets.sensorsImg,
                              effect: false),
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                // child: CustomBox(
                //     name: 'Pub/Sub Data', img: Assets.pubSubImg, effect: true),
              )
            : Center(child: showLoadingDialog()));
  }

  Future<bool> connectToBroker(BuildContext context, MqttServerClient client,
      String userName, String password) async {
    try {
      client.connectionStatus!.state = MqttConnectionState.connecting;
      return await client.connect(userName, password).then((value) {
        if (value!.state == MqttConnectionState.connected) {
          client.connectionStatus!.state = MqttConnectionState.connected;
          return true;
        } else {
          return false;
        }
      });
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      handlerDialog(context, 'Connection faild', e.toString(), Colors.red);
      return false;
    }
  }
}
