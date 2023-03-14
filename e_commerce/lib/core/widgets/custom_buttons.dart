import 'package:e_commerce/core/utils/size_config.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class GeneralcustomButton extends StatelessWidget {
  const GeneralcustomButton({super.key, this.text});
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: kMainColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text!,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xffffffff),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
        ));
  }
}
