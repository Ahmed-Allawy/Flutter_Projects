// ignore_for_file: unnecessary_const

import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce/core/constants.dart';
import 'package:e_commerce/core/utils/size_config.dart';
import 'package:e_commerce/core/widgets/custom_buttons.dart';
import 'package:e_commerce/features/Auth/presentation/pages/login/login_view.dart';
import 'package:e_commerce/features/on%20Boarding/presentation/widgets/custom_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});
  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  PageController? pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
        CustomPageView(
          pageController: pageController,
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: SizeConfig.defaultSize! * 15,
            child: DotsIndicator(
              dotsCount: 3,
              position: pageController!.hasClients ? pageController!.page! : 0,
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
          child: Visibility(
            visible: pageController!.hasClients
                ? (pageController!.page == 2 ? false : true)
                : true,
            child: const Text(
              'Skip',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Color(0xff898989),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Positioned(
          bottom: SizeConfig.defaultSize! * 5,
          left: SizeConfig.defaultSize! * 10,
          right: SizeConfig.defaultSize! * 10,
          child: GeneralcustomButton(
            text: pageController!.hasClients
                ? pageController!.page == 2
                    ? 'Get Start'
                    : 'Next'
                : 'Next',
            onTap: () {
              if (pageController!.page! < 2) {
                pageController!.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              } else {
                Get.to(() => const LoginView(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 500));
              }
            },
          ),
        ),
      ],
    );
  }
}
