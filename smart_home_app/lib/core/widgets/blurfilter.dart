import 'dart:ui';

import 'package:flutter/material.dart';

class BlurFilter extends StatelessWidget {
  final Widget child;
  final double sigmaX;
  final double sigmaY;
  const BlurFilter(
      {super.key, required this.child, this.sigmaX = 5.0, this.sigmaY = 5.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: sigmaX,
                sigmaY: sigmaY,
              ),
              child: child),
        ),
      ],
    );
  }
}
