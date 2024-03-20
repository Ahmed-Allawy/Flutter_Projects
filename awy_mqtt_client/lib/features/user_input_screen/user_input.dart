import 'package:awy_mqtt_client/features/user_input_screen/cubit/user_input_cubit.dart';
import 'package:awy_mqtt_client/features/user_input_screen/cubit/user_input_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../core/widgets/custom_decoration.dart';

class UserInputScreen extends StatelessWidget {
  const UserInputScreen({super.key, required this.client});
  final MqttServerClient? client;

  @override
  Widget build(BuildContext context) {
    final TextEditingController topicController = TextEditingController();
    final TextEditingController dataController = TextEditingController();
    final formKey1 = GlobalKey<FormState>();
    final formKey2 = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Pub/Sub Data',
          style: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Form(
              key: formKey1,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: topicController,
                        decoration: customInputDecoration(
                                'Topic1,Topic2,Topic3', 'home/kitchen/lamp1')
                            .copyWith(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 1.5, color: Colors.deepPurple)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Topic should not be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const Expanded(
                      flex: 0,
                      child: SizedBox(
                        width: 10,
                      )),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (formKey1.currentState!.validate()) {
                          client!.subscribe(
                              topicController.text.trim(), MqttQos.atMostOnce);
                          client!.updates!.listen((event) {
                            UserInputCubit.get(context).getDataAndTopic(event);
                          });
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 19),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      child: const Text('Subscribe'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey)),
                child: BlocBuilder<UserInputCubit, UserInputState>(
                    builder: (context, state) {
                  var dataLength = UserInputCubit.get(context).dataLength;

                  return ListView.builder(
                    itemCount: dataLength,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Text(
                              UserInputCubit.get(context)
                                  .data[dataLength - index - 1],
                              style: const TextStyle(
                                  color: Colors.deepPurple, fontSize: 25),
                            )
                          : Text(
                              UserInputCubit.get(context)
                                  .data[dataLength - index - 1],
                              style: const TextStyle(fontSize: 20),
                            );
                    },
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Form(
              key: formKey2,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 50,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: dataController,
                        decoration: customInputDecoration(
                                'Data', 'Any formating of data')
                            .copyWith(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 1.5, color: Colors.deepPurple)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Data field should not be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const Expanded(
                      flex: 0,
                      child: SizedBox(
                        width: 10,
                      )),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        if (formKey1.currentState!.validate() &&
                            formKey2.currentState!.validate()) {
                          UserInputCubit.get(context).publish(
                              client!,
                              topicController.text.trim(),
                              dataController.text.trim());
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 19),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      child: const Text('Publish'),
                    ),
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
