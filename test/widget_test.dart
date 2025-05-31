import 'package:expense_tracker_lite/providers/add_expense_provider.dart';
import 'package:expense_tracker_lite/screens/add_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker_lite/providers/add_expense_provider.dart';

void main() {
  testWidgets('Validate amount, category, and date fields on Save tap', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AddExpenseProvider>(
          create: (_) => AddExpenseProvider(),
          child: const AddExpenseScreen(),
        ),
      ),
    );

    final saveButton = find.text('Save');
    expect(saveButton, findsOneWidget);
    await tester.tap(saveButton);

    await tester.pumpAndSettle();

    expect(find.text('Enter amount'), findsOneWidget);

    expect(find.text('Choose Date'), findsOneWidget);

  });






    group('AddExpenseProvider.convertExpense', () {
      late AddExpenseProvider provider;
      setUp(() {
        provider = AddExpenseProvider();
      });

      test('should not convert amount if currency is USD', () {
        provider.selectedCurrency = {'code': 'USD', 'rate': 1.0};
        provider.amountController.text = '100';

        provider.convertExpense();

        expect(provider.convertedAmount, '100');
      });

      test('should convert amount correctly if currency is not USD', () {
        provider.selectedCurrency = {'code': 'EUR', 'rate': 0.85};
        provider.amountController.text = '85';

        provider.convertExpense();

        // 85 / 0.85 = 100
        expect(double.parse(provider.convertedAmount!), closeTo(100, 0.001));
      });
    });


}
