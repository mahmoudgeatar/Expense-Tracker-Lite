import 'package:expense_tracker_lite/widgets/my_text.dart';
import 'package:flutter/material.dart';

import '../../constants/color_manger.dart';

class AmountWidget extends StatelessWidget {
  const AmountWidget({
    super.key,
    required this.amount,
    required this.label,
    required this.icon,
  });

  final double amount;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: ColorManager.white,
                size: 24,
              ),
              MyText(
                title: label,
                size: 16,
                color: ColorManager.white,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                width: 6,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: MyText(
           title:  '\$$amount',
            size: 28,
            fontWeight: FontWeight.bold,
            color: ColorManager.white,
          ),
        ),
      ],
    );
  }
}