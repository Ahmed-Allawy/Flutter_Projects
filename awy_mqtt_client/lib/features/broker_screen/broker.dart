// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:awy_mqtt_client/features/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

import 'package:mqtt_client/mqtt_server_client.dart';

import '../../core/util/shared.dart';
import '../../core/widgets/custom_decoration.dart';

class BrokerConfigScreen extends StatelessWidget {
  BrokerConfigScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController brokerController = TextEditingController();
    final TextEditingController portController = TextEditingController();
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Broker Configrations',
          style: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: brokerController,
                      decoration:
                          customInputDecoration('Broker', 'broker.hivemq.com'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Broker should not be empty';
                        }
                        return null;
                      },
                    )),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    width: 300,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: portController,
                      decoration: customInputDecoration('Port', '1883'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Port should not be empty';
                        }
                        RegExp numericRegex = RegExp(r'^[0-9]+$');
                        if (!numericRegex.hasMatch(value)) {
                          return 'Port should be a number';
                        }
                        return null;
                      },
                    )),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    width: 300,
                    child: TextFormField(
                      obscureText: true,
                      controller: userNameController,
                      decoration: customInputDecoration('UserName', ''),
                    )),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: passwordController,
                      decoration: customInputDecoration('Password', ''),
                    )),
                const SizedBox(
                  height: 25,
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Shared.saveData(
                          key: 'broker', value: brokerController.text.trim());
                      Shared.saveData(
                          key: 'port',
                          value: int.parse(portController.text.trim()));
                      if (userNameController.text.trim().isNotEmpty) {
                        Shared.saveData(
                            key: 'userName',
                            value: userNameController.text.trim());
                      }
                      if (passwordController.text.trim().isNotEmpty) {
                        Shared.saveData(
                            key: 'password',
                            value: passwordController.text.trim());
                      }

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()));
                    }
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 19),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: const Text('Connect'),
                ),
              ],
            ),
          )),
    );
  }
}
