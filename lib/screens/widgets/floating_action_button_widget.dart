
import 'package:flutter/material.dart';

import '../../utils/navigation_helper.dart';
import '../add_expense_screen.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        AppNavigator.navigation(context, const AddExpenseScreen());
      },
      child: const Icon(Icons.add),
    );
  }
}

