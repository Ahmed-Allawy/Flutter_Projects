import 'package:flutter/cupertino.dart';

import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/space_widget.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({Key? key, this.title, this.subTitle, this.image})
      : super(key: key);

  final String? title;
  final String? subTitle;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalSpace(15),
        SizedBox(
            height: SizeConfig.defaultSize! * 25, child: Image.asset(image!)),
        const VerticalSpace(2.5),
        Text(
          title!,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: Color(0xff2f2e41),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.left,
        ),
        const VerticalSpace(1),
        Text(
          subTitle!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            fontSize: 15,
            color: Color(0xff78787c),
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
