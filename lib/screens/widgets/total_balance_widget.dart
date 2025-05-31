import 'package:expense_tracker_lite/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/color_manger.dart';

class TotalBalanceWidget extends StatelessWidget {
  const TotalBalanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  MyText(
                   title:  'Total Balance',
                    size: 18,
                    fontWeight: FontWeight.bold,
                  color: ColorManager.white

                  ),
                  const SizedBox(width: 6,),
                  Icon(FontAwesomeIcons.chevronUp,color: ColorManager.white,size: 12,)
                ],
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0),
              child: MyText(
               title:  '\$2,548,00',
                size: 42,
                fontWeight: FontWeight.bold,
                color: ColorManager.white,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(Icons.more_horiz,color: ColorManager.white,size: 32,),
        ),
      ],
    );
  }
}
