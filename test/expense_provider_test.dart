import 'package:expense_tracker_lite/models/expense_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:expense_tracker_lite/providers/expense_provider.dart';
import 'package:expense_tracker_lite/data/expense_database.dart';


class MockExpenseDatabase extends Mock implements ExpenseDatabase {}

class TestableExpenseProvider extends ExpenseProvider {
  final ExpenseDatabase testDb;

  TestableExpenseProvider(this.testDb);

  @override
  Future<void> loadExpenses({DateFilterType? filter = DateFilterType.last7Days}) async {
    isLoading = true;
    notifyListeners();

    final newExpenses = await testDb.getAllExpenses(
      offset: currentPage * 10,
      limit: 10,
      filter: filter,
    );

    if (currentPage == 0) {
      expenses.clear();
      expenses.addAll(newExpenses);
    } else {
      expenses.addAll(newExpenses);
    }

    isLoading = false;
    notifyListeners();
  }
}
void main() {
  late TestableExpenseProvider provider;
  late MockExpenseDatabase mockDatabase;

  setUp(() {
    mockDatabase = MockExpenseDatabase();
    provider = TestableExpenseProvider(mockDatabase);
  });

  test('Pagination logic: load page 0 then page 1', () async {
    final expensesPage1 = List.generate(
      10,
          (i) => Expense(
        id: i,
        category: 'Food',
        amount: i.toDouble(),
        date: '2023-01-01',
        receiptPath: '',
        currency: 'USD',
        usdAmount: i.toDouble(),
      ),
    );

    final expensesPage2 = List.generate(
      10,
          (i) => Expense(
        id: i + 10,
        category: 'Travel',
        amount: (i + 10).toDouble(),
        date: '2023-01-02',
        receiptPath: '',
        currency: 'USD',
        usdAmount: (i + 10).toDouble(),
      ),
    );

    when(mockDatabase.getAllExpenses(offset: 0, limit: 10, filter: anyNamed('filter')))
        .thenAnswer((_) async => expensesPage1);

    when(mockDatabase.getAllExpenses(offset: 10, limit: 10, filter: anyNamed('filter')))
        .thenAnswer((_) async => expensesPage2);

    await provider.loadExpenses(filter: provider.selectedFilter);
    expect(provider.expenses.length, 10);
    expect(provider.expenses, expensesPage1);

    provider.currentPage = 1;
    await provider.loadExpenses(filter: provider.selectedFilter);
    expect(provider.expenses.length, 20);
    expect(provider.expenses.sublist(0, 10), expensesPage1);
    expect(provider.expenses.sublist(10, 20), expensesPage2);
  });
}
