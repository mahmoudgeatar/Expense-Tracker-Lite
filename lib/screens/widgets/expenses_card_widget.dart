import 'package:expense_tracker_lite/providers/add_expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants/color_manger.dart';
import '../../models/expense_model.dart';
import '../../utils/helper.dart';
import '../../widgets/my_text.dart';

class ExpensesCardWidget extends StatelessWidget {
  final Expense expense;
  const ExpensesCardWidget({super.key, required this.expense});
  @override
  Widget build(BuildContext context) {
    final addExpenseProvider =
    Provider.of<AddExpenseProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: addExpenseProvider
                          .getCategoryData(expense.category)!
                          .color!
                          .withOpacity(.5),
                      borderRadius: BorderRadius.circular(50)),
                  child: IconButton(
                      icon: FaIcon(
                        addExpenseProvider
                            .getCategoryData(expense.category)!
                            .icon!,
                        color: addExpenseProvider
                            .getCategoryData(expense.category)!
                            .color!
                            .withOpacity(.5),
                      ),
                      onPressed: () {
                        // provider.changeSelectedCategory(e);
                      }),
                ),
                const SizedBox(width: 8,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title:  expense.category ,
                      fontWeight: FontWeight.w600,
                      size: 18,
                    ),
                    MyText(
                      title:  'Manually',
                      color: ColorManager.grey,
                      size: 16,
                      fontWeight: FontWeight.w500,

                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(

                  children: [
                    MyText(
                      title: '-\$${expense.usdAmount.toStringAsFixed(2)}',
                      size: 22,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.black,
                    ),
                    const SizedBox(width: 8,),
                    MyText(
                      title: '-\$${expense.amount.toStringAsFixed(2)}',
                      size: 14,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.grey,
                      decoration: TextDecoration.lineThrough,

                    ),
                  ],
                ),
                MyText(
                  title:  Helper.getDate(expense.date),
                  size: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.grey,
                ),


              ],
            )
          ],
        ),
      ),
    );
  }
}
