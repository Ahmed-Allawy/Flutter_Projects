import 'package:e_commerce/features/splash/presentation/widgets/splash_body.dart';
import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kMainColor,
      body: SplashViewBody(),
    );
  }
}
