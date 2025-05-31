// lib/providers/expense_provider.dart
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../data/expense_database.dart';
import '../models/expense_model.dart';

enum DateFilterType { last7Days, currentMonth }

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];
  bool isLoading = false;
  int currentPage = 0;

  DateFilterType selectedFilter = DateFilterType.last7Days;

  List<Expense> get expenses => _expenses;

  Future<void> loadExpenses(
      {DateFilterType? filter = DateFilterType.last7Days}) async {
    isLoading = true;
    notifyListeners();

    final newExpenses = await ExpenseDatabase.instance.getAllExpenses(
      offset: currentPage * 10,
      limit: 10,
      filter: filter,
    );
    if (currentPage == 0) {
      _expenses = newExpenses;
      notifyListeners();
    } else {
      _expenses.addAll(newExpenses);
      notifyListeners();
    }

    isLoading = false;
    notifyListeners();
  }

  double getTotalExpenses(List<Expense> expenses) {
    return expenses.fold(0.0, (sum, e) => sum + e.amount);
  }

  void onFilterChanged(DateFilterType? filter) {
    if (filter == null) return;

    selectedFilter = filter;
    currentPage = 0;

    loadExpenses(
      filter: selectedFilter,
    );
    notifyListeners();
  }


  Future<String> exportCSV(List<List<dynamic>> data) async {
    String csvData = const ListToCsvConverter().convert(data);
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/exported_data.csv';
    final file = File(path);
    await file.writeAsString(csvData);
    await OpenFile.open(path,isIOSAppOpen: true,);
    return path;
  }
}
