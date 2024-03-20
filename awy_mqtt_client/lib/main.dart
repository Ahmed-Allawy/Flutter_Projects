// ignore_for_file: must_be_immutable
import 'package:awy_mqtt_client/features/main_screen/main_screen.dart';
import 'package:awy_mqtt_client/features/ui_screen/cubit/ui_cubit.dart';
import 'package:awy_mqtt_client/features/user_input_screen/cubit/user_input_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'core/util/shared.dart';
import 'features/broker_screen/broker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Shared.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool clientState = Shared.getData(key: 'clientConnected') ?? false;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => UserInputCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => UICubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            return connected
                ? clientState
                    ? const MainScreen()
                    : BrokerConfigScreen()
                : const Scaffold(
                    body: Center(
                      child: Text("you are offline!"),
                    ),
                  );
          },
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'There are no bottons to push :)',
              ),
              Text(
                'Just turn off your internet.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
