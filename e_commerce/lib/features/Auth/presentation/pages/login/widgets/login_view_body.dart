import 'package:awesome_icons/awesome_icons.dart';
import 'package:e_commerce/core/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/size_config.dart';
import '../../../../../../core/widgets/space_widget.dart';
import '../../../complete_information/complete_information_view.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const VerticalSpace(10),
        SizedBox(
          height: SizeConfig.defaultSize! * 17,
          child: Image.asset('assets/images/logo.png'),
        ),
        const Text(
          'Fruit Market',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 51,
            fontWeight: FontWeight.bold,
            color: Color(0xff69a03a),
          ),
        ),
        const Expanded(child: SizedBox()),
        Row(children: <Widget>[
          const Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: CustomButtonWithIcon(
                text: 'login with',
                color: Color(0xFFdb3236),
                iconData: FontAwesomeIcons.googlePlusG,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomButtonWithIcon(
                text: 'login with',
                color: const Color(0xFF4267B2),
                iconData: FontAwesomeIcons.facebookF,
                onTap: () {
                  Get.to(() => const CompleteInformationView(),
                      duration: const Duration(milliseconds: 500),
                      transition: Transition.rightToLeft);
                },
              ),
            ),
          ),
        ]),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}
