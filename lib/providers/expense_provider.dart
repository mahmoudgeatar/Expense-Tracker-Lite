// lib/providers/expense_provider.dart
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../data/expense_database.dart';
import '../models/expense_model.dart';

enum DateFilterType { last7Days, currentMonth }

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];
  bool isLoading = false;

  DateFilterType selectedFilter = DateFilterType.last7Days;


  List<Expense> get expenses => _expenses;


  Future<void> loadExpenses(
      {int page = 0, DateFilterType? filter = DateFilterType.last7Days}) async {
    isLoading = true;
    notifyListeners();

    final newExpenses = await ExpenseDatabase.instance.getAllExpenses(
      offset: page * 10,
      limit: 10,
      filter: filter,
    );
    if (page == 0) {
      _expenses = newExpenses;
    } else {
      _expenses.addAll(newExpenses);
    }

    isLoading = false;
    notifyListeners();
  }



}
