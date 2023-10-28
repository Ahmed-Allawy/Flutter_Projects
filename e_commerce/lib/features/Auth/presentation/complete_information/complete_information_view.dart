import 'package:flutter/material.dart';

import 'widgest/complete_information_body.dart';

class CompleteInformationView extends StatelessWidget {
  const CompleteInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CompleteInformationBody(),
    );
  }
}
