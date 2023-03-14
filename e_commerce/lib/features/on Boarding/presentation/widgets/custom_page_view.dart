// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'page_view_item.dart';

class CustomPageView extends StatelessWidget {
  CustomPageView({Key? key, @required this.pageController}) : super(key: key);
  PageController? pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [
        PageViewItem(
          image: 'assets/images/onboarding1.png',
          title: 'E Shopping',
          subTitle: 'Explore  top organic fruits & grab them',
        ),
        PageViewItem(
          image: 'assets/images/onboarding2.png',
          title: 'Delivery on the way',
          subTitle: 'Get your order by speed delivery',
        ),
        PageViewItem(
          image: 'assets/images/onboarding3.png',
          title: 'Delivery Arrived',
          subTitle: 'Order is arrived at your Place',
        ),
      ],
    );
  }
}
