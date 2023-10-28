// ignore_for_file: prefer_const_constructors

import 'package:e_commerce/core/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/space_widget.dart';
import 'complete_information_item.dart';

class CompleteInformationBody extends StatelessWidget {
  const CompleteInformationBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            VerticalSpace(10),
            CompleteInfoItem(
              text: 'Enter your name',
            ),
            VerticalSpace(2),
            CompleteInfoItem(
              text: 'Enter your phone number',
            ),
            VerticalSpace(2),
            CompleteInfoItem(
              maxLines: 5,
              text: 'Enter your address',
            ),
            VerticalSpace(5),
            GeneralcustomButton(
              text: 'hahahaha',
            )
          ],
        ),
      ),
    );
  }
}

class CustomGeneralButton {}
