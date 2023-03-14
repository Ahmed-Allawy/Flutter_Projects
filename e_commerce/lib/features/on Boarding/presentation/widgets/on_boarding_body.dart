// ignore_for_file: unnecessary_const

import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce/core/constants.dart';
import 'package:e_commerce/core/utils/size_config.dart';
import 'package:e_commerce/core/widgets/custom_buttons.dart';
import 'package:e_commerce/features/on%20Boarding/presentation/widgets/custom_page_view.dart';
import 'package:flutter/material.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
        const CustomPageView(),
        Positioned(
            left: 0,
            right: 0,
            bottom: SizeConfig.defaultSize! * 15,
            child: DotsIndicator(
              dotsCount: 3,
              position: 0,
              decorator: const DotsDecorator(
                  color: Colors.transparent,
                  activeColor: kMainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      side: BorderSide(color: kMainColor))),
            )),
        Positioned(
          top: SizeConfig.defaultSize! * 7,
          right: 32,
          child: const Text(
            'Skip',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: const Color(0xff898989),
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Positioned(
          bottom: SizeConfig.defaultSize! * 5,
          left: SizeConfig.defaultSize! * 10,
          right: SizeConfig.defaultSize! * 10,
          child: const GeneralcustomButton(
            text: 'NEXT',
          ),
        ),
      ],
    );
  }
}
