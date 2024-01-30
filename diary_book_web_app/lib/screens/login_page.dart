import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFFB9C2D1),
            )),
        const Column(
          children: [Text('data')],
        ),
        Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFFB9C2D1),
            )),
      ],
    ));
  }
}
