import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_home_app/core/utils/helperFunctions.dart';
import 'package:smart_home_app/features/home/cubit/home_cubit.dart';
import 'package:smart_home_app/features/home/cubit/home_state.dart';
import 'package:smart_home_app/features/room1/room1.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../core/utils/assets.dart';
import '../../core/widgets/roomsBox.dart';
import '../../mqtt/topics.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    HOMECUBIT.get(context).client.subscribeToTopic(temRoom1);
    HOMECUBIT
        .get(context)
        .client
        .client!
        .updates!
        .listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      // final MqttPublishMessage recTopic = c[0].topic as MqttPublishMessage;
      HOMECUBIT.get(context).listenToBroker(
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message),
          c[0].topic);

      // print('YOU GOT A NEW MESSAGE:');
      // print('alla data isssss : ${c[0].topic}');
      // print('message from callback');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // HOMECUBIT.get(context).chartData =   HOMECUBIT.get(context).getChartData();
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(19, 18, 18, 1),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  image: DecorationImage(
                                      image: AssetImage(Assets.userImage),
                                      fit: BoxFit.fill
                                      // fit: BoxFit.cover,
                                      )),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome',
                                style: GoogleFonts.oswald(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 199, 195, 195),
                                ),
                              ),
                              Text(
                                'Ahmed Allawy',
                                style: GoogleFonts.oswald(
                                  fontSize: 15,
                                  color: Color.fromARGB(250, 255, 255, 255),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset(
                            Assets.menuImage,
                            width: 35,
                            height: 35,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Rooms',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'see all',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 128, 118, 118),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<HOMECUBIT, HOMESTATE>(
                  builder: (context, state) {
                    return Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        children: [
                          InkWell(
                            onTap: () {
                              nextScreen(context, Room1());
                            },
                            child: RoomsBox(
                              roomImage: Assets.livingRoomImage,
                              roomName: 'Living Room',
                              numberOfDevices:
                                  HOMECUBIT.get(context).getActiveDevice(),
                              effect: true,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // nextScreen(context, Room1());
                            },
                            child: RoomsBox(
                              roomImage: Assets.kitchenImage,
                              roomName: 'Kitchen Room',
                              numberOfDevices: '3',
                              effect: false,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // nextScreen(context, Room1());
                            },
                            child: RoomsBox(
                              roomImage: Assets.bedImage,
                              roomName: 'Bed Room',
                              numberOfDevices: '1',
                              effect: false,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // nextScreen(context, Room1());
                            },
                            child: RoomsBox(
                              roomImage: Assets.bathImage,
                              roomName: 'Bath Room',
                              numberOfDevices: '0',
                              effect: true,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                BlocBuilder<HOMECUBIT, HOMESTATE>(
                  builder: (context, state) {
                    return SizedBox(
                        width: double.infinity,
                        height: 170,
                        child: SfCartesianChart(
                          series: <LineSeries<LiveData, int>>[
                            LineSeries<LiveData, int>(
                              onRendererCreated:
                                  (ChartSeriesController controller) {
                                HOMECUBIT.get(context).chartSeriesController =
                                    controller;
                              },
                              dataSource: HOMECUBIT.get(context).chartData,
                              color: Color.fromARGB(255, 221, 52, 26),
                              xValueMapper: (LiveData sales, _) => sales.time,
                              yValueMapper: (LiveData sales, _) => sales.temp,
                            ),
                          ],
                          primaryXAxis: NumericAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              interval: 3,
                              title: AxisTitle(text: 'Time (seconds)', textStyle: TextStyle(color: Colors.white))),
                          primaryYAxis: NumericAxis(
                              axisLine: const AxisLine(width: 0),
                              majorTickLines: const MajorTickLines(size: 0),
                              title: AxisTitle(
                                  text: 'Temperature',
                                  textStyle: TextStyle(color: Colors.white))),
                        ));
                  },
                ),
                // SizedBox(
                //     width: double.infinity,
                //     height: 180,
                //     child: TemperatureChart(
                //       title: 'Temperature ',
                //       temperatureValue: num.parse(HOMECUBIT.get(context).temperature),
                //     )),
              ],
            ),
          )),
    );
  }
}
