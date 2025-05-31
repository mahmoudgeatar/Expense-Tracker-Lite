import 'package:expense_tracker_lite/screens/widgets/total_balance_widget.dart';
import 'package:flutter/material.dart';

import '../../constants/color_manger.dart';
import 'amount_widget.dart';

class BalanceCardWidget extends StatelessWidget {
  const BalanceCardWidget({
    super.key,
    required this.totalExpenses,
  });

  final double totalExpenses;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding:
      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: ColorManager.lightPrimary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TotalBalanceWidget(),
          SizedBox(height: MediaQuery.sizeOf(context).height * .05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AmountWidget(amount: 10840.00,label: "Income",icon: Icons.arrow_circle_down_sharp,),
              AmountWidget(amount: totalExpenses,label: "Expenses",icon: Icons.arrow_circle_up_sharp,),
            ],
          )
        ],
      ),
    );
  }
}
