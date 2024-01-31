import 'package:flutter/material.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailTextController = TextEditingController();
    final TextEditingController passwordTextController =
        TextEditingController();
    GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    return Material(
        child: Column(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFFB9C2D1),
            )),
        LoginForm(
            globalKey: globalKey,
            emailTextController: emailTextController,
            passwordTextController: passwordTextController),
        Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFFB9C2D1),
            )),
      ],
    ));
  }
}
