import 'package:flutter/material.dart';

import '../../constants/color_manger.dart';
import '../../widgets/my_text.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.0,vertical: MediaQuery.sizeOf(context).height * .015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            title: "Recent Expenses",
            size: 22,
            color: ColorManager.black,
            fontWeight: FontWeight.bold,
          ),
          MyText(
            title: "see all",
            size: 16,
            color: ColorManager.black,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
